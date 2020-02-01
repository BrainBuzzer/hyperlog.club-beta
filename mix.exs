defmodule Hyperlog.MixProject do
  use Mix.Project

  def project do
    [
      app: :hyperlog,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Hyperlog.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.11"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.1"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:pow, "~> 1.0.16"},
      {:plug_cowboy, "~> 2.0"},
      {:ueberauth, "~> 0.6"},
      {:oauth2, "~> 2.0", override: true},
      {:ueberauth_github, "~> 0.7"},
      {:ueberauth_discord, git: "https://github.com/BrainBuzzer/ueberauth_discord"},
      {:amqp, "~> 1.0"},
      {:bamboo, "~> 1.3.0"},
      {:earmark, "~> 1.4.3"},
      {:httpoison, "~> 1.6"},
      {:yaml_elixir, "~> 2.4.0"},
      {:neuron, "~> 4.1.0"},
      {:sentry, "~> 7.0"},
      {:jason, "~> 1.1"},
      poison: "~> 3.1"
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
