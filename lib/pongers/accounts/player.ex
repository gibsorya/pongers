defmodule Pongers.Accounts.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :name, :string
    field :stats, :map
    many_to_many :matches, Pongers.Events.Match, join_through: "players_matches"

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :stats])
    |> validate_required([:name])
  end
end
