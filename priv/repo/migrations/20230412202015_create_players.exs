defmodule Pongers.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string
      add :stats, :map

      timestamps()
    end
  end
end
