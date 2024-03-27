defmodule Matches.MatchesSchema do
  @moduledoc """
  Module that contains matche's schema and  its insert's functionality
  """

  use Ecto.Schema

  alias Matches.Repo

  @type t :: %{
          home_team: Integer.t(),
          away_team: String.t(),
          created_at: Integer.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t(),
          kickoff_at: NaiveDateTime.t(),
          provider: Sting.t()
        }

  schema "matches" do
    field(:home_team, :string)
    field(:away_team, :string)
    field(:created_at, :integer)
    field(:kickoff_at, :naive_datetime)
    field(:provider, :string)

    timestamps()
  end

  @doc """
  insert data to matches table doing nothing in case of conflict
  """
  def insert_all(data) do
    Repo.insert_all(__MODULE__, data, on_conflict: :nothing)
  end
end
