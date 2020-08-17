defmodule Contracts.Repo do
  use Ecto.Repo,
    otp_app: :contracts,
    adapter: Ecto.Adapters.Postgres
end
