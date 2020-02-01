defmodule Hyperlog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :password_hash, :string
      add :name, :string
      add :github_connected, :boolean, default: false, null: false
      add :discord_connected, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
