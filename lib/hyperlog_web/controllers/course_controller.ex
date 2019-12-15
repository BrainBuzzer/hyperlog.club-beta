defmodule HyperlogWeb.CourseController do
  use HyperlogWeb, :controller
  alias Hyperlog.Courses
  def index(conn, _params) do
    render(conn, "index.html")
  end

  def javascript_course_start(conn, %{"slug" => slug}) do
    course = Courses.get_course!(1)
    lesson = Courses.get_lesson_by_slug(slug)
    render(conn, "js_course.html", course: course)
  end
end
