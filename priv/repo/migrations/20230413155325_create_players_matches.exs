defmodule Pongers.Repo.Migrations.CreatePlayersMatches do
  use Ecto.Migration

  def change do
    create table(:players_matches, primary_key: false) do
      add :player_id, references(:players, on_delete: :nothing), primary_key: true
      add :match_id, references(:matches, on_delete: :nothing), primary_key: true
    end

    create index(:players_matches, [:player_id])
    create index(:players_matches, [:match_id])
  end
end
