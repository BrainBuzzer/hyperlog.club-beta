defmodule Hyperlog.Courses.Chapter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chapter" do
    field :name, :string
    field :slug, :string

    embeds_many :lessons, Hyperlog.Courses.Lesson

    belongs_to :course, Hyperlog.Courses.Course

    timestamps()
  end

  @doc false
  def changeset(chapter, attrs) do
    chapter
    |> cast(attrs, [:name, :slug, :course_id])
    |> validate_required([:name, :slug, :course_id])
    |> cast_embed(:lessons)
  end
end
