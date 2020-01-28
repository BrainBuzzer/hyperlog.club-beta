defmodule Hyperlog.Repo.Migrations.CreateUserAchievementsJoinTable do
  use Ecto.Migration

  def change do
    create table(:users_achievements, primary_key: false) do
      add :user_id, references(:user_profile, on_delete: :delete_all)
      add :achievements_id, references(:achievements, on_delete: :nothing)
    end
  end
end
