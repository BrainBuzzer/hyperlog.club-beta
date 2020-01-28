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

alias Hyperlog.Courses
alias Hyperlog.Accounts
alias Hyperlog.Profile

dev_roles = [
  %{name: "Beginner Role", discord_id: "653880931320463361", type: "experience"},
  %{name: "Intermediate Role", discord_id: "653881077118533633", type: "experience"},
  %{name: "Advanced Role", discord_id: "655131756277530634", type: "experience"},
  %{name: "Student", discord_id: "655131817921478676", type: "position"},
  %{name: "Teacher", discord_id: "655131795444072457", type: "position"},
  %{name: "Professional", discord_id: "655131836804104202", type: "position"},
  %{name: "C", discord_id: "111", type: "language"},
  %{name: "Elixir", discord_id: "123", type: "language"},
  %{name: "Rust", discord_id: "2135", type: "language"},
  %{name: "Python", discord_id: "123561", type: "language"},
  %{name: "JavaScript", discord_id: "1231", type: "language"}
]

prod_roles = [
  %{name: "Newbie", discord_id: "635163076345331751", type: "experience"},
  %{name: "Intermediate", discord_id: "635163115872321576", type: "experience"},
  %{name: "Advanced", discord_id: "635163358684905492", type: "experience"},
  %{name: "Student", discord_id: "635163468755894302", type: "position"},
  %{name: "Professional", discord_id: "635163852727910419", type: "position"},
  %{name: "C", discord_id: "626820700690317328", type: "language"},
  %{name: "C++", discord_id: "635162595355000834", type: "language"},
  %{name: "Elixir", discord_id: "635162976407519243", type: "language"},
  %{name: "JavaScript", discord_id: "635163033471287327", type: "language"},
  %{name: "Python", discord_id: "670958995934150667", type: "language"}
]

case Mix.env() do
  :dev ->
    for role <- dev_roles do
      Accounts.create_role(role)
    end
  :prod ->
    for role <- prod_roles do
      Accounts.create_role(role)
    end
end

achievements = [
  %{name: "HelloWorld()", description: "Welcome to the community!", xp_gain: 0, badge: "https://image.flaticon.com/icons/png/512/87/87140.png", achievement_uid: "hello_world"},
  %{name: "ConnectDiscord()", description: "Connect to the Discord Account!", xp_gain: 10, badge: "https://image.flaticon.com/icons/png/512/87/87140.png", achievement_uid: "connect_discord"},
  %{name: "ConnectGithub()", description: "Connect to the GitHub Account!", xp_gain: 10, badge: "https://image.flaticon.com/icons/png/512/87/87140.png", achievement_uid: "connect_github"}
]

for achievement <- achievements do
  Profile.create_achievements(achievement)
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
