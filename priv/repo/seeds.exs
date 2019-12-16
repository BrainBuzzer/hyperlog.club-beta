# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Hyperlog.Repo.insert!(%Hyperlog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Hyperlog.Resources
alias Hyperlog.Courses
alias Hyperlog.Accounts

for category <- ~w(Article Video) do
  Resources.create_category(category)
end

for tech <- ~w(JavaScript Python) do
  Resources.create_technology(tech)
end

roles = [
  %{name: "Beginner Role", discord_id: "653880931320463361"},
  %{name: "Intermediate Role", discord_id: "653881077118533633"},
  %{name: "Advanced Role", discord_id: "655131756277530634"},
  %{name: "Student", discord_id: "655131817921478676"},
  %{name: "Teacher", discord_id: "655131795444072457"},
  %{name: "Professional", discord_id: "655131836804104202"},
]

for role <- roles do
  Accounts.create_role(role)
end

%HTTPoison.Response{status_code: 200, body: body} = HTTPoison.get! "https://raw.githubusercontent.com/BrainBuzzer/hyperlog-curriculum/master/courses.yaml"
{:ok, courses} = YamlElixir.read_from_string(body)
for course <- courses do
  course_slug = course["slug"]
  {:ok, course} = Courses.create_course(course)

  %HTTPoison.Response{status_code: 200, body: body} = HTTPoison.get! "https://raw.githubusercontent.com/BrainBuzzer/hyperlog-curriculum/master/#{course_slug}/chapters.yaml"
  {:ok, chapters} = YamlElixir.read_from_string(body)
  for chapter <- chapters do
    lessons = Enum.map(chapter["lessons"], fn lesson_name ->
      %HTTPoison.Response{status_code: 200, body: body} = HTTPoison.get! "https://raw.githubusercontent.com/BrainBuzzer/hyperlog-curriculum/master/#{course_slug}/#{chapter["slug"]}/#{lesson_name}"
      case String.split(body, ~r/\n-{3,}\n/, parts: 2) do
        [frontmatter, content] ->
          {:ok, lesson} = YamlElixir.read_from_string(frontmatter)
          lesson = Map.put(lesson, "content", content)
      end
    end)
    new_chapter = %{name: chapter["name"], slug: chapter["slug"], course_id: course.id, lessons: lessons}
    Courses.create_chapter(new_chapter)
  end
end
