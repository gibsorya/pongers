defmodule Pongers.EventsTest do
  use Pongers.DataCase

  alias Pongers.Events

  describe "matches" do
    alias Pongers.Events.Match

    import Pongers.EventsFixtures

    @invalid_attrs %{data: nil, date: nil}

    test "list_matches/0 returns all matches" do
      match = match_fixture()
      assert Events.list_matches() == [match]
    end

    test "get_match!/1 returns the match with given id" do
      match = match_fixture()
      assert Events.get_match!(match.id) == match
    end

    test "create_match/1 with valid data creates a match" do
      valid_attrs = %{data: %{}, date: ~D[2023-04-12]}

      assert {:ok, %Match{} = match} = Events.create_match(valid_attrs)
      assert match.data == %{}
      assert match.date == ~D[2023-04-12]
    end

    test "create_match/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_match(@invalid_attrs)
    end

    test "update_match/2 with valid data updates the match" do
      match = match_fixture()
      update_attrs = %{data: %{}, date: ~D[2023-04-13]}

      assert {:ok, %Match{} = match} = Events.update_match(match, update_attrs)
      assert match.data == %{}
      assert match.date == ~D[2023-04-13]
    end

    test "update_match/2 with invalid data returns error changeset" do
      match = match_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_match(match, @invalid_attrs)
      assert match == Events.get_match!(match.id)
    end

    test "delete_match/1 deletes the match" do
      match = match_fixture()
      assert {:ok, %Match{}} = Events.delete_match(match)
      assert_raise Ecto.NoResultsError, fn -> Events.get_match!(match.id) end
    end

    test "change_match/1 returns a match changeset" do
      match = match_fixture()
      assert %Ecto.Changeset{} = Events.change_match(match)
    end
  end
end
