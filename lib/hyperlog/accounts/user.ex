defmodule Hyperlog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  use Pow.Ecto.Schema
  use Pow.Extension.Ecto.Schema, extensions: [PowInvitation]

  schema "users" do
    pow_user_fields()
    field :discord_connected, :boolean, default: false
    field :github_connected, :boolean, default: false
    field :name, :string
    field :role, :string, default: "user"

    has_one :profile, Hyperlog.Profile.User
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
    |> pow_extension_changeset(attrs)
    |> cast(attrs, [:name, :email, :github_connected, :discord_connected])
    |> validate_required([:name, :email, :github_connected, :discord_connected])
    |> unique_constraint(:email)
    |> foreign_key_constraint(:roles_id)
  end

  @spec changeset_role(Ecto.Schema.t() | Ecto.Changeset.t(), map()) :: Ecto.Changeset.t()
  def changeset_role(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:role])
    |> Ecto.Changeset.validate_inclusion(:role, ~w(user admin))
  end
end
