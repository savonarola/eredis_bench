defmodule EredisBench do
  defp bulk_data(chunk_size, chunk_count) do
    chunk = (1..chunk_size) |> Enum.map(&rem(&1, 256)) |> :erlang.list_to_binary
    chunks = for _ <- 1..chunk_count, do: chunk
    [ "$#{chunk_size * chunk_count}\r\n" ] ++ chunks ++ ["\r\n"]
  end

  defp parse_bulk_data([chunk | rest], parser \\ :eredis_parser.init) do
    case :eredis_parser.parse(parser, chunk) do
      {:ok, value, _} -> value
      {:continue, new_parser} -> parse_bulk_data(rest, new_parser)
    end
  end

  defp msacc(fun) do
    :msacc.start
    :msacc.reset
    fun.()
    stats = :msacc.stats
    {
      :msacc.stats(:system_realtime, stats),
      :msacc.stats(:system_runtime, stats)
    }
  end

  defp make_probes(n, fun) do
    stats = for _ <- 1..n, do: msacc(fun)
    system_realtime = stats |> Enum.map(fn {t, _} -> t end)
    system_runtime = stats |> Enum.map(fn {_, t} -> t end)

    IO.puts "probes: #{n}"
    IO.puts "system_realtime: mean #{Statistics.mean(system_realtime)}, median: #{Statistics.median(system_realtime)}"
    IO.puts "system_runtime: mean #{Statistics.mean(system_runtime)}, median: #{Statistics.median(system_runtime)}"
  end

  def benchmark_parse_bulk(opts) do
    data = bulk_data(4096, 256 * opts[:bulk_size_mb])
    make_probes(opts[:probe_count], fn ->
      parse_bulk_data(data)
    end)
  end
end
