defmodule PongersWeb.WebappController do
  use PongersWeb, :controller

  def index(conn, _params) do
    conn
    |> send_resp(200, render_svelte_app())
  end

  defp render_svelte_app do
    Application.app_dir(:pongers, "priv/static/webapp/index.html")
    |> File.read!()
  end
end
