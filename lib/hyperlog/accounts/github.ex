defmodule Hyperlog.Accounts.Github do
  use Ecto.Schema
  import Ecto.Changeset

  schema "github" do
    field :access_token, :string

    belongs_to :user, Hyperlog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(github, attrs) do
    github
    |> cast(attrs, [:access_token, :refresh_token])
    |> validate_required([:access_token, :refresh_token])
  end
end
