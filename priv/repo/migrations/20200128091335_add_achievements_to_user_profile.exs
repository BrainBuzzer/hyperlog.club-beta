defmodule Hyperlog.Repo.Migrations.AddAchievementsToUserProfile do
  use Ecto.Migration

  def change do
    alter table(:user_profile) do
      add :achievements_id, references(:achievements, on_delete: :nothing)
    end

    create index(:user_profile, [:achievements_id])
  end
end
