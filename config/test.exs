import Config

config :matches, Matches.Repo,
  database: "matches_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  log: false

config :matches, sleep: 0
config :matches, http_client: HttpClientMock
