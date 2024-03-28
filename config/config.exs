import Config

config :matches, Matches.Repo,
  database: "matches_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :matches, ecto_repos: [Matches.Repo]

import_config("#{Mix.env()}.exs")
