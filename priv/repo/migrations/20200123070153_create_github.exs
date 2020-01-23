defmodule Hyperlog.Repo.Migrations.CreateGithub do
  use Ecto.Migration

  def change do
    create table(:github) do
      add :access_token, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:github, [:user_id])
  end
end
