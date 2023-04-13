defmodule Pongers.Events.Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matches" do
    field :data, :map
    field :date, :date

    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:date, :data])
    |> validate_required([:date, :data])
  end
end
