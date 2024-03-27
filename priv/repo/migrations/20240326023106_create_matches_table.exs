defmodule Matches.Repo.Migrations.CreateMatchesTable do
  use Ecto.Migration

  def change do
    create table(:matches) do

      add :home_team, :string, null: false
      add :away_team, :string, null: false
      add :kickoff_at, :naive_datetime, null: false
      add :provider, :string, null: false
      add :created_at, :integer, null: false
      timestamps()
    end

    create unique_index(:matches, [:home_team, :away_team, :kickoff_at])
  end
end
