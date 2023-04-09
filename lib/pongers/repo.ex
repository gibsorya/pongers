defmodule Pongers.Repo do
  use Ecto.Repo,
    otp_app: :pongers,
    adapter: Ecto.Adapters.Postgres
end
