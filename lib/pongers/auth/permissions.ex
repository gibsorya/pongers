defmodule Pongers.Auth.Permissions do
  @moduledoc """
  Permissions module for checking if a user has access to a resource.
  """

  def create_player do
    MapSet.new(["create:player"])
  end
end
