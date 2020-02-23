defmodule HyperlogWeb.MongoHelper do
  def create_github_user(email) do
    {:ok, mongo_conn} = Mongo.start_link(url: "mongodb://localhost:27017/hyperlog")
    Mongo.insert_one(mongo_conn, "user_stats", %{email: email, status: "processing"})
  end
end
