defmodule Hyperlog.Repo do
  use Ecto.Repo,
    otp_app: :hyperlog,
    adapter: Ecto.Adapters.Postgres
end
