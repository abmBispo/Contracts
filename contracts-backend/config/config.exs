# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :contracts,
  ecto_repos: [Contracts.Repo]

# Configures the endpoint
config :contracts, ContractsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bPlLa8woifM4qDGv4iDgpNaCgVVK2xH9wC6WHmZRf+bCWPHpePHpEeFgHYeWd8Sl",
  render_errors: [view: ContractsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Contracts.PubSub,
  live_view: [signing_salt: "SmOR1qlQ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
