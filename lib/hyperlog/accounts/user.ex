defmodule Hyperlog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    field :discord_connected, :boolean, default: false
    field :github_connected, :boolean, default: false
    field :name, :string
    field :username, :string

    has_one :discord, Hyperlog.Accounts.Discord
    has_one :github, Hyperlog.Accounts.Github
    has_many :projects, Hyperlog.Project.MetaData
    many_to_many :roles, Hyperlog.Accounts.Role, join_through: "users_roles", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> pow_user_id_field_changeset(attrs)
    |> pow_password_changeset(attrs)
    |> cast(attrs, [:name, :email, :username, :github_connected, :discord_connected])
    |> validate_required([:name, :email, :username, :github_connected, :discord_connected])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> foreign_key_constraint(:roles_id)
  end
end
