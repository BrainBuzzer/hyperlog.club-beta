defmodule Hyperlog.Project.MetaData do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :description, :string
    field :link, :string
    field :name, :string

    belongs_to :user, Hyperlog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(meta_data, attrs) do
    meta_data
    |> cast(attrs, [:name, :description, :link])
    |> validate_required([:name, :description, :link])
    |> unique_constraint(:link)
  end
end
