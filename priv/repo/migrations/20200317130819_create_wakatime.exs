defmodule Hyperlog.Repo.Migrations.CreateWakatime do
  use Ecto.Migration

  def change do
    create table(:wakatime) do
      add :access_token, :string
      add :refresh_token, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:wakatime, [:user_id])
  end
end
