defmodule Hyperlog.Repo.Migrations.CreateTechnology do
  use Ecto.Migration

  def change do
    create table(:technology) do
      add :name, :string

      timestamps()
    end

  end
end
