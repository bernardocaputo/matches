defmodule Matches.MixProject do
  use Mix.Project

  def project do
    [
      app: :matches,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
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
           {Matches.Providers.FastBall, 0},
           {Matches.Providers.MatchBeam, 15000}
         ]}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:httpoison, "~> 2.2"},
      {:jason, "~> 1.4"},
      {:postgrex, ">= 0.0.0"}
    ]
  end
end
