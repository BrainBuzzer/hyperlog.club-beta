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

for category <- ~w(Article Video) do
  Resources.create_category(category)
end

for tech <- ~w(JavaScript Python) do
  Resources.create_technology(tech)
end
