defmodule EredisBench.Mixfile do
  use Mix.Project

  def project do
    [app: :eredis_bench,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :eredis]]
  end

  defp deps do
    [
      {:eredis, git: "https://github.com/wooga/eredis.git"},
      # {:eredis, git: "https://github.com/savonarola/eredis.git", branch: "optimize_binary_operations"},
      {:statistics, "~> 0.4.0"}
    ]
  end
end
