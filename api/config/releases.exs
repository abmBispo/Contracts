# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

config :contracts, Contracts.Repo,
  ssl: true,
  url: System.get_env("database_url"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "2")

secret_key_base = "wV9U4NiV8VvmJC1/iG7IEIj2prOaZmwUB2scsx7f4IAcHMXm4TdulKjOsFHVlTaH"

config :contracts, ContractsWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
config :contracts, ContractsWeb.Endpoint, server: true

# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
