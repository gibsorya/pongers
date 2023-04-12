defmodule PongersWeb.PlayerController do
  use PongersWeb, :controller

  alias Pongers.Accounts
  alias Pongers.Accounts.Player

  action_fallback PongersWeb.FallbackController

  def index(conn, _params) do
    players = Accounts.list_players()
    render(conn, :index, players: players)
  end

  def create(conn, %{"player" => player_params}) do
    with {:ok, %Player{} = player} <- Accounts.create_player(player_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/players/#{player}")
      |> render(:show, player: player)
    end
  end

  def show(conn, %{"id" => id}) do
    player = Accounts.get_player!(id)
    render(conn, :show, player: player)
  end

  def update(conn, %{"id" => id, "player" => player_params}) do
    player = Accounts.get_player!(id)

    with {:ok, %Player{} = player} <- Accounts.update_player(player, player_params) do
      render(conn, :show, player: player)
    end
  end

  def delete(conn, %{"id" => id}) do
    player = Accounts.get_player!(id)

    with {:ok, %Player{}} <- Accounts.delete_player(player) do
      send_resp(conn, :no_content, "")
    end
  end
end
