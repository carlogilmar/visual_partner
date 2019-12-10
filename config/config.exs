# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :star,
  ecto_repos: [Star.Repo]

# Configures the endpoint
config :star, StarWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5J3kREXc8ZtwosYjFg+iDhSmMgz6IIYzf/Bozg+06F3Nf1q/Z3MHgQzbhZ52C0PD",
  render_errors: [view: StarWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Star.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "YMuY0SjtHY3Mtn+jkIvFscOYaTUPrdAm"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
config :phoenix, template_engines: [leex: Phoenix.LiveView.Engine]

config :star, Star.Guardian,
  issuer: "star",
  secret_key: "vAlJF6VWR+iTwuYYHkgmatQyd/MvMIBAAMNk/VTt2RWxItJAppiZr4fVfa7AGw37"

# In your config/config.exs file
config :star, Star.Mailer,
  adapter: Bamboo.SendGridAdapter,
  api_key: System.get_env("SENDGRID_API_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
