defmodule Hyperlog.Repo.Migrations.AddUserOnboardToUsers do
  use Ecto.Migration

  def change do
    alter table :users do
      add :onboard_complete, :boolean, default: false
    end
  end
end
