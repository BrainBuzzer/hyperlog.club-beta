defmodule Hyperlog.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :description, :string
      add :link, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:projects, [:link])
    create index(:projects, [:user_id])
  end
end
