# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hyperlog,
  ecto_repos: [Hyperlog.Repo]

# Configures the endpoint
config :hyperlog, HyperlogWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+SXQYsLC/+S7QN8hZGqO/yH5tJDp0DLMZrBS3WMGIn2Z5XRtztRJcS558+69rv6y",
  render_errors: [view: HyperlogWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Hyperlog.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [default_scope: "user:email"]},
    discord: {Ueberauth.Strategy.Discord, [default_scope: "identify email guilds guilds.join messages.read"]}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

config :ueberauth, Ueberauth.Strategy.Discord.OAuth,
  client_id: System.get_env("DISCORD_CLIENT_ID"),
  client_secret: System.get_env("DISCORD_CLIENT_SECRET"),
  redirect_uri: "http://localhost:4000/auth/discord/callback"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
