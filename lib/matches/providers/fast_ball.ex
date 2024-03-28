defmodule Matches.Providers.FastBall do
  @behaviour Matches.Providers.ProviderBehaviour

  alias Matches.DataFecher.HttpClient

  @fast_ball_endpoint "http://forzaassignment.forzafootball.com:8080/feed/fastball"

  @impl true
  def fetch_data() do
    http_client().get(@fast_ball_endpoint)
  end

  @impl true
  def prepare_data(data) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    Enum.map(data, fn map -> do_prepare(map, now) end)
  end

  defp do_prepare(
         %{
           "home_team" => home_team,
           "away_team" => away_team,
           "created_at" => created_at,
           "kickoff_at" => kickoff_at
         },
         now
       ) do
    %{
      home_team: home_team,
      away_team: away_team,
      kickoff_at: NaiveDateTime.from_iso8601!(kickoff_at),
      created_at: created_at,
      inserted_at: now,
      updated_at: now,
      provider: "fastball"
    }
  end

  defp http_client() do
    Application.get_env(:matches, :http_client, HttpClient)
  end
end
