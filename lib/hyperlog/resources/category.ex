defmodule Hyperlog.Resources.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "category" do
    field :name, :string

    has_many :tutorials, Hyperlog.Resources.Tutorial

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
