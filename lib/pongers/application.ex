defmodule Pongers.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PongersWeb.Telemetry,
      # Start the Ecto repository
      Pongers.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Pongers.PubSub},
      # Start Finch
      {Finch, name: Pongers.Finch},
      # Start the Endpoint (http/https)
      PongersWeb.Endpoint,
      # Start a worker by calling: Pongers.Worker.start_link(arg)
      # {Pongers.Worker, arg}
      Pongers.Auth.Auth0Strategy
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pongers.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PongersWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
