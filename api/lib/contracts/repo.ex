defmodule Contracts.Repo do
  use Ecto.Repo,
    otp_app: :contracts,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 25
end
