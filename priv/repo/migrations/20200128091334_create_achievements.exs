defmodule Hyperlog.Repo.Migrations.CreateAchievements do
  use Ecto.Migration

  def change do
    create table(:achievements) do
      add :name, :string
      add :badge, :string
      add :xp_gain, :integer
      add :description, :string
      add :achievement_uid, :string
      add :user_id, references(:user_profile, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:achievements, [:achievement_uid])
    create index(:achievements, [:user_id])
  end
end
