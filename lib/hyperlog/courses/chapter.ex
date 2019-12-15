defmodule Hyperlog.Courses.Chapter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chapter" do
    field :name, :string

    embeds_many :lessons, Hyperlog.Courses.Lesson

    belongs_to :course, Hyperlog.Courses.Course

    timestamps()
  end

  @doc false
  def changeset(chapter, attrs) do
    chapter
    |> cast(attrs, [:name, :course_id])
    |> validate_required([:name, :course_id])
    |> cast_embed(:lessons)
  end
end
