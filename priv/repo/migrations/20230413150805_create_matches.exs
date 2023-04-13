defmodule Pongers.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :date, :date
      add :data, :map

      timestamps()
    end
  end
end
