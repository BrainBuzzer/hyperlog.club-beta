defmodule Hyperlog.ProfileTest do
  use Hyperlog.DataCase

  alias Hyperlog.Profile

  describe "user_profile" do
    alias Hyperlog.Profile.User

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Profile.create_user()

      user
    end

    test "list_user_profile/0 returns all user_profile" do
      user = user_fixture()
      assert Profile.list_user_profile() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Profile.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Profile.create_user(@valid_attrs)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Profile.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Profile.update_user(user, @update_attrs)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Profile.update_user(user, @invalid_attrs)
      assert user == Profile.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Profile.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Profile.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Profile.change_user(user)
    end
  end

  describe "achievements" do
    alias Hyperlog.Profile.Achievements

    @valid_attrs %{badge: "some badge", description: "some description", name: "some name", xp_gain: "some xp_gain"}
    @update_attrs %{badge: "some updated badge", description: "some updated description", name: "some updated name", xp_gain: "some updated xp_gain"}
    @invalid_attrs %{badge: nil, description: nil, name: nil, xp_gain: nil}

    def achievements_fixture(attrs \\ %{}) do
      {:ok, achievements} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Profile.create_achievements()

      achievements
    end

    test "list_achievements/0 returns all achievements" do
      achievements = achievements_fixture()
      assert Profile.list_achievements() == [achievements]
    end

    test "get_achievements!/1 returns the achievements with given id" do
      achievements = achievements_fixture()
      assert Profile.get_achievements!(achievements.id) == achievements
    end

    test "create_achievements/1 with valid data creates a achievements" do
      assert {:ok, %Achievements{} = achievements} = Profile.create_achievements(@valid_attrs)
      assert achievements.badge == "some badge"
      assert achievements.description == "some description"
      assert achievements.name == "some name"
      assert achievements.xp_gain == "some xp_gain"
    end

    test "create_achievements/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Profile.create_achievements(@invalid_attrs)
    end

    test "update_achievements/2 with valid data updates the achievements" do
      achievements = achievements_fixture()
      assert {:ok, %Achievements{} = achievements} = Profile.update_achievements(achievements, @update_attrs)
      assert achievements.badge == "some updated badge"
      assert achievements.description == "some updated description"
      assert achievements.name == "some updated name"
      assert achievements.xp_gain == "some updated xp_gain"
    end

    test "update_achievements/2 with invalid data returns error changeset" do
      achievements = achievements_fixture()
      assert {:error, %Ecto.Changeset{}} = Profile.update_achievements(achievements, @invalid_attrs)
      assert achievements == Profile.get_achievements!(achievements.id)
    end

    test "delete_achievements/1 deletes the achievements" do
      achievements = achievements_fixture()
      assert {:ok, %Achievements{}} = Profile.delete_achievements(achievements)
      assert_raise Ecto.NoResultsError, fn -> Profile.get_achievements!(achievements.id) end
    end

    test "change_achievements/1 returns a achievements changeset" do
      achievements = achievements_fixture()
      assert %Ecto.Changeset{} = Profile.change_achievements(achievements)
    end
  end
end
