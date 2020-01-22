defmodule Hyperlog.ProjectTest do
  use Hyperlog.DataCase

  alias Hyperlog.Project

  describe "projects" do
    alias Hyperlog.Project.MetaData

    @valid_attrs %{description: "some description", link: "some link", name: "some name"}
    @update_attrs %{description: "some updated description", link: "some updated link", name: "some updated name"}
    @invalid_attrs %{description: nil, link: nil, name: nil}

    def meta_data_fixture(attrs \\ %{}) do
      {:ok, meta_data} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Project.create_meta_data()

      meta_data
    end

    test "list_projects/0 returns all projects" do
      meta_data = meta_data_fixture()
      assert Project.list_projects() == [meta_data]
    end

    test "get_meta_data!/1 returns the meta_data with given id" do
      meta_data = meta_data_fixture()
      assert Project.get_meta_data!(meta_data.id) == meta_data
    end

    test "create_meta_data/1 with valid data creates a meta_data" do
      assert {:ok, %MetaData{} = meta_data} = Project.create_meta_data(@valid_attrs)
      assert meta_data.description == "some description"
      assert meta_data.link == "some link"
      assert meta_data.name == "some name"
    end

    test "create_meta_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Project.create_meta_data(@invalid_attrs)
    end

    test "update_meta_data/2 with valid data updates the meta_data" do
      meta_data = meta_data_fixture()
      assert {:ok, %MetaData{} = meta_data} = Project.update_meta_data(meta_data, @update_attrs)
      assert meta_data.description == "some updated description"
      assert meta_data.link == "some updated link"
      assert meta_data.name == "some updated name"
    end

    test "update_meta_data/2 with invalid data returns error changeset" do
      meta_data = meta_data_fixture()
      assert {:error, %Ecto.Changeset{}} = Project.update_meta_data(meta_data, @invalid_attrs)
      assert meta_data == Project.get_meta_data!(meta_data.id)
    end

    test "delete_meta_data/1 deletes the meta_data" do
      meta_data = meta_data_fixture()
      assert {:ok, %MetaData{}} = Project.delete_meta_data(meta_data)
      assert_raise Ecto.NoResultsError, fn -> Project.get_meta_data!(meta_data.id) end
    end

    test "change_meta_data/1 returns a meta_data changeset" do
      meta_data = meta_data_fixture()
      assert %Ecto.Changeset{} = Project.change_meta_data(meta_data)
    end
  end
end
