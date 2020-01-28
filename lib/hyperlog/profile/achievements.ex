defmodule Hyperlog.Profile.Achievements do
  use Ecto.Schema
  import Ecto.Changeset

  schema "achievements" do
    field :badge, :string
    field :description, :string
    field :name, :string
    field :xp_gain, :integer
    field :achievement_uid, :string

    many_to_many :users, Hyperlog.Profile.User, join_through: "users_achievements", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(achievements, attrs) do
    achievements
    |> cast(attrs, [:name, :badge, :xp_gain, :description])
    |> validate_required([:name, :badge, :xp_gain, :description])
  end
end
