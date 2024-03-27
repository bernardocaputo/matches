defmodule Matches.Providers.MatchBeam do
  @behaviour Matches.Providers.Behaviour

  alias Matches.DataFecher.HttpClient

  @match_beam_endpoint "http://forzaassignment.forzafootball.com:8080/feed/matchbeam"

  def fetch_data() do
    http_client().get(@match_beam_endpoint)
  end

  def prepare_data(data) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    Enum.map(data, fn map -> do_prepare(map, now) end)
  end

  defp do_prepare(%{"teams" => teams, "kickoff_at" => kickoff, "created_at" => created_at}, now) do
    [home_team, away_team] = String.split(teams, " - ")

    %{
      home_team: home_team,
      away_team: away_team,
      kickoff_at: NaiveDateTime.from_iso8601!(kickoff),
      created_at: created_at,
      inserted_at: now,
      updated_at: now,
      provider: "match_beam"
    }
  end

  defp http_client() do
    Application.get_env(:matches, :match_beam_provider, HttpClient)
  end
end
