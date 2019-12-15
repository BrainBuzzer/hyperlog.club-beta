defmodule Hyperlog.Courses.Lesson do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :title
    field :content
    field :difficulty
    field :slug
    field :type
  end

  def changeset(lesson, params) do
    lesson
    |> cast(params, [:title, :content, :difficulty, :slug, :type])
    |> validate_required([:title, :content, :difficulty, :slug, :type])
  end
end

