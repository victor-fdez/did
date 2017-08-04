# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :did,
  ecto_repos: [Did.Repo]

# Configures the endpoint
config :did, Did.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DioIk8i9KZYTOYIQOEFSVYf/f5agAv30TAbP7PifwY5kH20I/BARad31Gmwx+fuk",
  render_errors: [view: Did.ErrorView, accepts: ~w(json)],
  pubsub: [name: Did.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
