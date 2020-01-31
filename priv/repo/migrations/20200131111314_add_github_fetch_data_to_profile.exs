defmodule Hyperlog.Repo.Migrations.AddGithubFetchDataToProfile do
  use Ecto.Migration

  def change do
    alter table :user_profile do
      add :username, :string
      add :bio, :string
      add :company, :string
      add :email, :string
      add :avatar, :string
      add :website, :string
    end

    create unique_index(:user_profile, [:username])
  end
end
