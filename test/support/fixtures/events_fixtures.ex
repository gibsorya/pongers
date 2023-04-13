defmodule Pongers.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pongers.Events` context.
  """

  @doc """
  Generate a match.
  """
  def match_fixture(attrs \\ %{}) do
    {:ok, match} =
      attrs
      |> Enum.into(%{
        data: %{},
        date: ~D[2023-04-12]
      })
      |> Pongers.Events.create_match()

    match
  end
end
