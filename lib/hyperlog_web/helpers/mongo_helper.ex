defmodule HyperlogWeb.MongoHelper do
  def create_github_user(email) do
    {:ok, mongo_conn} = Mongo.start_link(url: System.get_env("MONGODB_CONNECT_URL"))
    Mongo.insert_one(mongo_conn, "user_stats", %{email: email, status: "processing"})
  end

  def create_github_project(url) do
    {:ok, mongo_conn} = Mongo.start_link(url: System.get_env("MONGODB_CONNECT_URL"))
    Mongo.insert_one(mongo_conn, "project_stats", %{url: url, status: "processing"})
  end
end
