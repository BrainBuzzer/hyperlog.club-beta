defmodule Hyperlog.Profile.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_profile" do
    many_to_many :achievements, Hyperlog.Profile.Achievements, join_through: "users_achievements", on_replace: :delete

    belongs_to :user, Hyperlog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [])
    |> validate_required([])
    |> foreign_key_constraint(:achievements_id)
  end
end
