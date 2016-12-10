# EredisBench

Original `wooga/eredis` parser:

```elixir
iex(1)> EredisBench.benchmark_parse_bulk probe_count: 100, bulk_size_mb: 150
probes: 100
system_realtime: mean 3759849.28, median: 3707978.5
system_runtime: mean 252962.46, median: 249221.0
:ok
iex(2)> EredisBench.benchmark_parse_bulk probe_count: 100, bulk_size_mb: 1  
probes: 100
system_realtime: mean 426953.22, median: 19214.0
system_runtime: mean 1801.25, median: 1525.5
:ok
```

Optimized parser:

```elixir
iex(1)> EredisBench.benchmark_parse_bulk probe_count: 100, bulk_size_mb: 150
probes: 100
system_realtime: mean 713101.37, median: 443085.0
system_runtime: mean 50588.51, median: 32450.0
:ok
iex(2)> EredisBench.benchmark_parse_bulk probe_count: 100, bulk_size_mb: 1  
probes: 100
system_realtime: mean 765323.56, median: 5049.5
system_runtime: mean 1195.32, median: 1000.5
:ok
```

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
