defmodule Hyperlog.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "course" do
    field :description, :string
    field :name, :string

    has_many :chapters, Hyperlog.Courses.Chapter

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
