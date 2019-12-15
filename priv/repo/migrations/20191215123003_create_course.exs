defmodule Hyperlog.Repo.Migrations.CreateCourse do
  use Ecto.Migration

  def change do
    create table(:course) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
