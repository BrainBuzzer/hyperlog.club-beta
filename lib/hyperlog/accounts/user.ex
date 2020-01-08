defmodule Hyperlog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :avatar, :string
    field :discord_connected, :boolean, default: false
    field :email, :string
    field :house, :string, default: "None"
    field :name, :string
    field :username, :string
    field :xp, :integer, default: 0
    field :onboard_complete, :boolean, default: false

    has_one :discord, Hyperlog.Accounts.Discord
    has_many :tutorials, Hyperlog.Resources.Tutorial
    many_to_many :roles, Hyperlog.Accounts.Role, join_through: "users_roles", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :username, :avatar, :discord_connected, :xp, :house, :onboard_complete])
    |> validate_required([:name, :email, :username, :avatar, :discord_connected, :xp, :house, :onboard_complete])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> foreign_key_constraint(:roles_id)
  end
end
