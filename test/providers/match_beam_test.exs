defmodule Test.Providers.MatchBeamTest do
  use ExUnit.Case

  alias Matches.Providers.MatchBeam
  import Mox

  setup do
    expect(
      HttpClientMock,
      :get,
      fn "http://forzaassignment.forzafootball.com:8080/feed/matchbeam" ->
        {:ok,
         [
           %{
             "teams" => "Arsenal - Chelsea FC",
             "kickoff_at" => 1_543_741_200,
             "created_at" => "2018-12-19T09:00:00Z"
           }
         ]}
      end
    )

    :ok
  end

  describe "fetch_data/0" do
    test "fetch data successfully" do
      assert assert {:ok,
                     [
                       %{
                         "teams" => "Arsenal - Chelsea FC",
                         "kickoff_at" => 1_543_741_200,
                         "created_at" => "2018-12-19T09:00:00Z"
                       }
                     ]} = MatchBeam.fetch_data()
    end
  end

  describe "prepare_data/1" do
    test "prepare data successfully" do
      datetime = NaiveDateTime.from_iso8601!("2018-12-19T09:00:00Z")

      assert [
               %{
                 away_team: "Chelsea FC",
                 kickoff_at: ^datetime,
                 home_team: "Arsenal",
                 inserted_at: _,
                 created_at: 1_543_741_200,
                 provider: "matchbeam",
                 updated_at: _
               }
             ] =
               MatchBeam.prepare_data([
                 %{
                   "teams" => "Arsenal - Chelsea FC",
                   "kickoff_at" => "2018-12-19T09:00:00Z",
                   "created_at" => 1_543_741_200
                 }
               ])
    end
  end
end
