use Mix.Config

# Configure your database
config :hyperlog, Hyperlog.Repo,
  username: "postgres",
  password: "postgres",
  database: "hyperlog_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hyperlog, HyperlogWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
