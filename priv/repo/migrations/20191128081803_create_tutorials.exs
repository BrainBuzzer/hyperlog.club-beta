defmodule Hyperlog.Repo.Migrations.CreateTutorials do
  use Ecto.Migration

  def change do
    create table(:tutorials) do
      add :title, :string
      add :difficulty, :integer
      add :description, :string
      add :link, :string
      add :category_id, references(:category, on_delete: :nothing)
      add :technology_id, references(:technology, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:tutorials, [:link])
    create index(:tutorials, [:category_id])
    create index(:tutorials, [:technology_id])
    create index(:tutorials, [:user_id])
  end
end
