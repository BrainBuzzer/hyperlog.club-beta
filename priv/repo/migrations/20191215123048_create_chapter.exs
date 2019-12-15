defmodule Hyperlog.Repo.Migrations.CreateChapter do
  use Ecto.Migration

  def change do
    create table(:chapter) do
      add :name, :string
      add :course_id, references(:course, on_delete: :nothing)

      add :lessons, {:array, :map}, default: []

      timestamps()
    end

    create index(:chapter, [:course_id])
  end
end
