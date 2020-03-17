defmodule Hyperlog.Accounts.Wakatime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wakatime" do
    field :access_token, :string
    field :refresh_token, :string

    belongs_to :user, Hyperlog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(wakatime, attrs) do
    wakatime
    |> cast(attrs, [:access_token, :refresh_token])
    |> validate_required([:access_token, :refresh_token])
  end
end
