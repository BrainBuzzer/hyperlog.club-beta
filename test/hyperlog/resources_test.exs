defmodule Hyperlog.ResourcesTest do
  use Hyperlog.DataCase

  alias Hyperlog.Resources

  describe "category" do
    alias Hyperlog.Resources.Category

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_category()

      category
    end

    test "list_category/0 returns all category" do
      category = category_fixture()
      assert Resources.list_category() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Resources.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Resources.create_category(@valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = Resources.update_category(category, @update_attrs)
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_category(category, @invalid_attrs)
      assert category == Resources.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Resources.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Resources.change_category(category)
    end
  end

  describe "technology" do
    alias Hyperlog.Resources.Technology

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def technology_fixture(attrs \\ %{}) do
      {:ok, technology} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_technology()

      technology
    end

    test "list_technology/0 returns all technology" do
      technology = technology_fixture()
      assert Resources.list_technology() == [technology]
    end

    test "get_technology!/1 returns the technology with given id" do
      technology = technology_fixture()
      assert Resources.get_technology!(technology.id) == technology
    end

    test "create_technology/1 with valid data creates a technology" do
      assert {:ok, %Technology{} = technology} = Resources.create_technology(@valid_attrs)
      assert technology.name == "some name"
    end

    test "create_technology/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_technology(@invalid_attrs)
    end

    test "update_technology/2 with valid data updates the technology" do
      technology = technology_fixture()
      assert {:ok, %Technology{} = technology} = Resources.update_technology(technology, @update_attrs)
      assert technology.name == "some updated name"
    end

    test "update_technology/2 with invalid data returns error changeset" do
      technology = technology_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_technology(technology, @invalid_attrs)
      assert technology == Resources.get_technology!(technology.id)
    end

    test "delete_technology/1 deletes the technology" do
      technology = technology_fixture()
      assert {:ok, %Technology{}} = Resources.delete_technology(technology)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_technology!(technology.id) end
    end

    test "change_technology/1 returns a technology changeset" do
      technology = technology_fixture()
      assert %Ecto.Changeset{} = Resources.change_technology(technology)
    end
  end

  describe "tutorials" do
    alias Hyperlog.Resources.Tutorial

    @valid_attrs %{description: "some description", difficulty: 42, link: "some link", title: "some title"}
    @update_attrs %{description: "some updated description", difficulty: 43, link: "some updated link", title: "some updated title"}
    @invalid_attrs %{description: nil, difficulty: nil, link: nil, title: nil}

    def tutorial_fixture(attrs \\ %{}) do
      {:ok, tutorial} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_tutorial()

      tutorial
    end

    test "list_tutorials/0 returns all tutorials" do
      tutorial = tutorial_fixture()
      assert Resources.list_tutorials() == [tutorial]
    end

    test "get_tutorial!/1 returns the tutorial with given id" do
      tutorial = tutorial_fixture()
      assert Resources.get_tutorial!(tutorial.id) == tutorial
    end

    test "create_tutorial/1 with valid data creates a tutorial" do
      assert {:ok, %Tutorial{} = tutorial} = Resources.create_tutorial(@valid_attrs)
      assert tutorial.description == "some description"
      assert tutorial.difficulty == 42
      assert tutorial.link == "some link"
      assert tutorial.title == "some title"
    end

    test "create_tutorial/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_tutorial(@invalid_attrs)
    end

    test "update_tutorial/2 with valid data updates the tutorial" do
      tutorial = tutorial_fixture()
      assert {:ok, %Tutorial{} = tutorial} = Resources.update_tutorial(tutorial, @update_attrs)
      assert tutorial.description == "some updated description"
      assert tutorial.difficulty == 43
      assert tutorial.link == "some updated link"
      assert tutorial.title == "some updated title"
    end

    test "update_tutorial/2 with invalid data returns error changeset" do
      tutorial = tutorial_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_tutorial(tutorial, @invalid_attrs)
      assert tutorial == Resources.get_tutorial!(tutorial.id)
    end

    test "delete_tutorial/1 deletes the tutorial" do
      tutorial = tutorial_fixture()
      assert {:ok, %Tutorial{}} = Resources.delete_tutorial(tutorial)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_tutorial!(tutorial.id) end
    end

    test "change_tutorial/1 returns a tutorial changeset" do
      tutorial = tutorial_fixture()
      assert %Ecto.Changeset{} = Resources.change_tutorial(tutorial)
    end
  end
end
