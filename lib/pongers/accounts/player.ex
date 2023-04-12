defmodule Pongers.Accounts.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :name, :string
    field :stats, :map

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :stats])
    |> validate_required([:name, :stats])
  end
end
