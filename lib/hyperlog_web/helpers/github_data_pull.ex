defmodule HyperlogWeb.PullGithubData do
  alias Hyperlog.Repo
  alias Hyperlog.Profile

  def pull_user_repo(access_token) do
    Neuron.Config.set(url: "https://api.github.com/graphql")
    Neuron.Config.set(headers: [Authorization: "bearer #{access_token}"])
    Neuron.query("""
      query {
        viewer {
          repositories(orderBy: {field: NAME, direction: ASC}, first: 100, isFork: false) {
            edges {
              node {
                nameWithOwner
                description
                stargazers{
                  totalCount
                }
              }
            }
          }
        }
      }
    """)
  end

  def pull_data(user_id, access_token) do
    Neuron.Config.set(url: "https://api.github.com/graphql")
    Neuron.Config.set(headers: [Authorization: "bearer #{access_token}"])
    Neuron.Config.set(json_library: Poison)
    {:ok, %Neuron.Response{body: body, status_code: 200}} = Neuron.query("""
    query {
      viewer {
        login
        bio
        avatarUrl
        email
        websiteUrl
        company
      }
    }
    """)
    save_user_data(user_id, body["data"])
  end

  defp save_user_data(user_id, user_data) do
    Profile.update_user(Repo.get_by(Profile.User, %{user_id: user_id}), %{
      username: user_data["viewer"]["login"],
      bio: user_data["viewer"]["bio"],
      email: user_data["viewer"]["email"],
      website: user_data["viewer"]["websiteUrl"],
      company: user_data["viewer"]["company"],
      avatar: user_data["viewer"]["avatarUrl"]
    })
  end
end
