defmodule Hyperlog.Repo.Migrations.CreateUserProfile do
  use Ecto.Migration

  def change do
    create table(:user_profile) do
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:user_profile, [:user_id])
  end
end
