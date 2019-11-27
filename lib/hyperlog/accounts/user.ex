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

    has_one :discord, Hyperlog.Accounts.Discord

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :username, :avatar, :discord_connected, :xp, :house])
    |> validate_required([:name, :email, :username, :avatar, :discord_connected, :xp, :house])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
