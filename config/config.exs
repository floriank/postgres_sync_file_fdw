# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :postgres_sync_file_fdw,
  ecto_repos: [PostgresSyncFileFdw.Repo]

# Configures the endpoint
config :postgres_sync_file_fdw, PostgresSyncFileFdwWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base:
    "hLNWYrM62SA5cxVOy57n3DUTdhvwWSzg7yFeYpstz3IHiU+RKUEWw4SxfsAlKaK1",
  render_errors: [view: PostgresSyncFileFdwWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: PostgresSyncFileFdw.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
