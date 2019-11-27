defmodule Hyperlog.Repo.Migrations.CreateUserDiscord do
  use Ecto.Migration

  def change do
    create table(:user_discord) do
      add :email, :string
      add :access_token, :string
      add :refresh_token, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:user_discord, [:email])
    create index(:user_discord, [:user_id])
  end
end
