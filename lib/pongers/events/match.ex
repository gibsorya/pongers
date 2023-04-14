defmodule Pongers.Events.Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matches" do
    field :data, :map
    field :date, :date
    many_to_many :players, Pongers.Accounts.Player, join_through: "players_matches"

    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:date, :data])
    |> validate_required([:date, :data])
  end
end
