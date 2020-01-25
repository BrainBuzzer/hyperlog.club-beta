defmodule Hyperlog.Repo.Migrations.UpdateRolesAddTypeField do
  use Ecto.Migration

  def change do
    alter table(:roles) do
      add :type, :string
    end
  end
end
