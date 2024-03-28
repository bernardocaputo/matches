defmodule Matches.MixProject do
  use Mix.Project

  def project do
    [
      app: :matches,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod:
        {Matches.Application,
         [
           Matches.Providers.FastBall,
           Matches.Providers.MatchBeam
         ]}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:httpoison, "~> 2.2"},
      {:jason, "~> 1.4"},
      {:mox, "~> 1.0", only: :test},
      {:postgrex, ">= 0.0.0"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases() do
    [
      test: "test --no-start"
    ]
  end
end
