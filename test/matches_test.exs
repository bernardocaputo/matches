defmodule MatchesTest do
  use ExUnit.Case

  alias Matches
  alias Matches.Repo
  alias Matches.MatchesSchema
  alias Matches.Providers.FastBall
  alias Matches.Providers.MatchBeam

  import Mox

  setup do
    start_supervised(Matches.Repo)
    :ok
  end

  describe "process/1" do
    test "process fastball successfully" do
      expect(
        HttpClientMock,
        :get,
        fn "http://forzaassignment.forzafootball.com:8080/feed/fastball" ->
          {:ok,
           [
             %{
               "home_team" => "Arsenal",
               "away_team" => "Chelsea FC",
               "kickoff_at" => "2018-12-19T09:00:00Z",
               "created_at" => 1_543_741_200
             }
           ]}
        end
      )

      assert :ok = Matches.process(FastBall)

      assert [
               %MatchesSchema{
                 home_team: "Arsenal",
                 away_team: "Chelsea FC",
                 kickoff_at: ~N[2018-12-19 09:00:00],
                 created_at: 1_543_741_200,
                 provider: "fastball",
                 inserted_at: _,
                 updated_at: _
               }
             ] = Repo.all(MatchesSchema)
    end

    test "process matchbeam successfully" do
      expect(
        HttpClientMock,
        :get,
        fn "http://forzaassignment.forzafootball.com:8080/feed/matchbeam" ->
          {:ok,
           [
             %{
               "teams" => "Arsenal - Chelsea FC",
               "created_at" => 1_543_741_200,
               "kickoff_at" => "2018-12-19T09:00:00Z"
             }
           ]}
        end
      )

      assert :ok = Matches.process(MatchBeam)

      assert [
               %MatchesSchema{
                 home_team: "Arsenal",
                 away_team: "Chelsea FC",
                 kickoff_at: ~N[2018-12-19 09:00:00],
                 created_at: 1_543_741_200,
                 provider: "fastball",
                 inserted_at: _,
                 updated_at: _
               }
             ] = Repo.all(MatchesSchema)
    end
  end
end
