defmodule Hyperlog.Accounts.Discord do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_discord" do
    field :access_token, :string
    field :email, :string
    field :refresh_token, :string
    field :discord_uid, :string

    belongs_to :user, Hyperlog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(discord, attrs) do
    discord
    |> cast(attrs, [:email, :access_token, :refresh_token, :discord_uid])
    |> validate_required([:email, :access_token, :refresh_token, :discord_uid])
    |> unique_constraint(:email)
    |> unique_constraint(:discord_uid)
  end
end
