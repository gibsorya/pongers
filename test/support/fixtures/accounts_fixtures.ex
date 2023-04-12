defmodule Pongers.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pongers.Accounts` context.
  """

  @doc """
  Generate a player.
  """
  def player_fixture(attrs \\ %{}) do
    {:ok, player} =
      attrs
      |> Enum.into(%{
        name: "some name",
        stats: %{}
      })
      |> Pongers.Accounts.create_player()

    player
  end
end
