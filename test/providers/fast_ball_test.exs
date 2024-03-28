defmodule Test.Providers.FastBallTest do
  use ExUnit.Case

  alias Matches.Providers.FastBall
  import Mox

  setup do
    expect(
      HttpClientMock,
      :get,
      fn "http://forzaassignment.forzafootball.com:8080/feed/fastball" ->
        {:ok,
         [
           %{
             "home_team" => "Arsenal",
             "away_team" => "Chelsea FC",
             "created_at" => 1_543_741_200,
             "kickoff_at" => "2018-12-19T09:00:00Z"
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
                         "away_team" => "Chelsea FC",
                         "kickoff_at" => "2018-12-19T09:00:00Z",
                         "home_team" => "Arsenal",
                         "created_at" => 1_543_741_200
                       }
                     ]} = FastBall.fetch_data()
    end
  end

  describe "prepare_data/1" do
    test "prepare data successfully" do
      {:ok, datetime} = NaiveDateTime.from_iso8601("2018-12-19T09:00:00Z")

      assert [
               %{
                 away_team: "Chelsea FC",
                 kickoff_at: ^datetime,
                 home_team: "Arsenal",
                 inserted_at: _,
                 created_at: 1_543_741_200,
                 provider: "fastball",
                 updated_at: _
               }
             ] =
               FastBall.prepare_data([
                 %{
                   "away_team" => "Chelsea FC",
                   "created_at" => 1_543_741_200,
                   "kickoff_at" => "2018-12-19T09:00:00Z",
                   "home_team" => "Arsenal"
                 }
               ])
    end
  end
end
