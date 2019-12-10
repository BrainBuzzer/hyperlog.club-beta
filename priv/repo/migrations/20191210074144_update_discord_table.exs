defmodule Hyperlog.Repo.Migrations.UpdateDiscordTable do
  use Ecto.Migration

  def change do
    alter table(:user_discord) do
      add :discord_uid, :string
    end

    create unique_index(:user_discord, [:discord_uid])
  end
end
