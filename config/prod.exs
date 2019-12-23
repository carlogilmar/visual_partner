use Mix.Config

config :star, StarWeb.Endpoint,
  http: [:inet6, port: System.get_env("PORT") || 4000],
  url: [host: "starcg.herokuapp.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json",
  base_url: "https://apprenticesjourney.herokuapp.com/"

# Do not print debug messages in production
config :logger, level: :info

# Configure your database
config :star, Star.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true,
  url: System.get_env("DATABASE_URL")
