defmodule Hyperlog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :password_hash, :string
      add :name, :string
      add :username, :string
      add :avatar, :string
      add :discord_connected, :boolean, default: false, null: false
      add :xp, :integer, default: 0
      add :house, :string, default: "None"

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
  end
end
