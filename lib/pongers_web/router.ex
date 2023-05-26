defmodule PongersWeb.Router do
  use PongersWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PongersWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authorize do
    plug Pongers.Auth.Authorize
  end

  pipeline :validate_permissions do
    plug Pongers.Auth.ValidatePermissions, Pongers.Auth.Permissions.create_player()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PongersWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", PongersWeb do
    pipe_through [:api]

    resources "/players", PlayerController, only: [:index, :show]
    resources "/matches", MatchController, only: [:index, :show]
  end

  scope "/api", PongersWeb do
    pipe_through [:api, :authorize, :validate_permissions]

    resources "/players", PlayerController, only: [:create, :update, :delete, :new, :edit]
    resources "/matches", MatchController, only: [:create, :update, :delete, :new, :edit]
  end

  scope "/app", PongersWeb do
    get "/", WebappController, :index
    get "/*path", WebappController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PongersWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:pongers, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PongersWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
