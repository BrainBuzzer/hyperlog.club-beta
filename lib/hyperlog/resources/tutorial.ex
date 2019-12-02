defmodule Hyperlog.Resources.Tutorial do
  use Ecto.Schema
  import Ecto.Changeset

  alias Hyperlog.Resources.{ Category, Technology }

  schema "tutorials" do
    field :description, :string
    field :difficulty, :integer
    field :link, :string
    field :title, :string

    belongs_to :category, Category
    belongs_to :technology, Technology

    belongs_to :user, Hyperlog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(tutorial, attrs) do
    tutorial
    |> cast(attrs, [:title, :difficulty, :description, :link, :category_id, :technology_id])
    |> validate_required([:title, :difficulty, :description, :link, :category_id, :technology_id])
    |> unique_constraint(:link)
  end
end
