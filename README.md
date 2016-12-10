# EredisBench

This repo contains code comparing resourse consumption of `eredis` parsers:
original `wooga/eredis` parser (https://github.com/wooga/eredis/blob/master/src/eredis_parser.erl)
and an optimized parser https://github.com/savonarola/eredis/blob/optimize_binary_operations/src/eredis_parser.erl.

Original `wooga/eredis` parser:

```elixir
iex(1)> EredisBench.benchmark_parse_bulk probe_count: 100, bulk_size_mb: 150
probes: 100
system_realtime: mean 3759849.28 us, median: 3707978.5 us
system_runtime: mean 252962.46 us, median: 249221.0 us
:ok
iex(2)> EredisBench.benchmark_parse_bulk probe_count: 100, bulk_size_mb: 1  
probes: 100
system_realtime: mean 426953.22 us, median: 19214.0 us
system_runtime: mean 1801.25 us, median: 1525.5 us
:ok
```

Optimized parser:

```elixir
iex(1)> EredisBench.benchmark_parse_bulk probe_count: 100, bulk_size_mb: 150
probes: 100
system_realtime: mean 713101.37 us, median: 443085.0 us
system_runtime: mean 50588.51 us, median: 32450.0 us
:ok
iex(2)> EredisBench.benchmark_parse_bulk probe_count: 100, bulk_size_mb: 1  
probes: 100
system_realtime: mean 765323.56 us, median: 5049.5 us
system_runtime: mean 1195.32 us, median: 1000.5 us
:ok
```

`system_realtime` isn't very useful, but `system_runtime` indicates CPU time
 consumed by scheduler threads. Otimized parser has significantly lower CPU usage
 for large bulks.


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `eredis_bench` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:eredis_bench, "~> 0.1.0"}]
    end
    ```

  2. Ensure `eredis_bench` is started before your application:

    ```elixir
    def application do
      [applications: [:eredis_bench]]
    end
    ```
