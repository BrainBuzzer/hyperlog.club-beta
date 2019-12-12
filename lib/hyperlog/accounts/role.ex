defmodule Hyperlog.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :discord_id, :string
    field :name, :string

    many_to_many :users, Hyperlog.Accounts.User, join_through: "users_roles", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :discord_id])
    |> validate_required([:name, :discord_id])
  end
end
