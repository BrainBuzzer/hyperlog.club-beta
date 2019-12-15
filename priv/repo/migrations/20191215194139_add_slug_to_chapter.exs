defmodule Hyperlog.Repo.Migrations.AddSlugToChapter do
  use Ecto.Migration

  def change do
    alter table(:chapter) do
      add :slug, :string
    end
  end
end
