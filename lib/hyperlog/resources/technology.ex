defmodule Hyperlog.Resources.Technology do
  use Ecto.Schema
  import Ecto.Changeset

  schema "technology" do
    field :name, :string

    has_many :tutorials, Hyperlog.Resources.Tutorial

    timestamps()
  end

  @doc false
  def changeset(technology, attrs) do
    technology
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
