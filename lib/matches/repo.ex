defmodule Matches.Repo do
  use Ecto.Repo,
    otp_app: :matches,
    adapter: Ecto.Adapters.Postgres
end
