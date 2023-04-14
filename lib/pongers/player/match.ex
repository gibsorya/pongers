defmodule Pongers.Player.Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players_matches" do

    field :player_id, :id
    field :match_id, :id

    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [])
    |> validate_required([])
  end
end
