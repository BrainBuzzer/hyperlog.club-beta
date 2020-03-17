defmodule Hyperlog.Repo.Migrations.UpdateUserAddWakatimeConnected do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :wakatime_connected, :boolean, default: false
    end
  end
end
