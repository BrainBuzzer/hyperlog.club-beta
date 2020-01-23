defmodule Hyperlog.AccountsTest do
  use Hyperlog.DataCase

  alias Hyperlog.Accounts

  describe "users" do
    alias Hyperlog.Accounts.User

    @valid_attrs %{avatar: "some avatar", discord_connected: true, email: "some email", house: "some house", name: "some name", username: "some username", xp: 42}
    @update_attrs %{avatar: "some updated avatar", discord_connected: false, email: "some updated email", house: "some updated house", name: "some updated name", username: "some updated username", xp: 43}
    @invalid_attrs %{avatar: nil, discord_connected: nil, email: nil, house: nil, name: nil, username: nil, xp: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.avatar == "some avatar"
      assert user.discord_connected == true
      assert user.email == "some email"
      assert user.house == "some house"
      assert user.name == "some name"
      assert user.username == "some username"
      assert user.xp == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.avatar == "some updated avatar"
      assert user.discord_connected == false
      assert user.email == "some updated email"
      assert user.house == "some updated house"
      assert user.name == "some updated name"
      assert user.username == "some updated username"
      assert user.xp == 43
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "user_discord" do
    alias Hyperlog.Accounts.Discord

    @valid_attrs %{access_token: "some access_token", email: "some email", refresh_token: "some refresh_token"}
    @update_attrs %{access_token: "some updated access_token", email: "some updated email", refresh_token: "some updated refresh_token"}
    @invalid_attrs %{access_token: nil, email: nil, refresh_token: nil}

    def discord_fixture(attrs \\ %{}) do
      {:ok, discord} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_discord()

      discord
    end

    test "list_user_discord/0 returns all user_discord" do
      discord = discord_fixture()
      assert Accounts.list_user_discord() == [discord]
    end

    test "get_discord!/1 returns the discord with given id" do
      discord = discord_fixture()
      assert Accounts.get_discord!(discord.id) == discord
    end

    test "create_discord/1 with valid data creates a discord" do
      assert {:ok, %Discord{} = discord} = Accounts.create_discord(@valid_attrs)
      assert discord.access_token == "some access_token"
      assert discord.email == "some email"
      assert discord.refresh_token == "some refresh_token"
    end

    test "create_discord/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_discord(@invalid_attrs)
    end

    test "update_discord/2 with valid data updates the discord" do
      discord = discord_fixture()
      assert {:ok, %Discord{} = discord} = Accounts.update_discord(discord, @update_attrs)
      assert discord.access_token == "some updated access_token"
      assert discord.email == "some updated email"
      assert discord.refresh_token == "some updated refresh_token"
    end

    test "update_discord/2 with invalid data returns error changeset" do
      discord = discord_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_discord(discord, @invalid_attrs)
      assert discord == Accounts.get_discord!(discord.id)
    end

    test "delete_discord/1 deletes the discord" do
      discord = discord_fixture()
      assert {:ok, %Discord{}} = Accounts.delete_discord(discord)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_discord!(discord.id) end
    end

    test "change_discord/1 returns a discord changeset" do
      discord = discord_fixture()
      assert %Ecto.Changeset{} = Accounts.change_discord(discord)
    end
  end

  describe "github" do
    alias Hyperlog.Accounts.Github

    @valid_attrs %{access_token: "some access_token", refresh_token: "some refresh_token"}
    @update_attrs %{access_token: "some updated access_token", refresh_token: "some updated refresh_token"}
    @invalid_attrs %{access_token: nil, refresh_token: nil}

    def github_fixture(attrs \\ %{}) do
      {:ok, github} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_github()

      github
    end

    test "list_github/0 returns all github" do
      github = github_fixture()
      assert Accounts.list_github() == [github]
    end

    test "get_github!/1 returns the github with given id" do
      github = github_fixture()
      assert Accounts.get_github!(github.id) == github
    end

    test "create_github/1 with valid data creates a github" do
      assert {:ok, %Github{} = github} = Accounts.create_github(@valid_attrs)
      assert github.access_token == "some access_token"
      assert github.refresh_token == "some refresh_token"
    end

    test "create_github/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_github(@invalid_attrs)
    end

    test "update_github/2 with valid data updates the github" do
      github = github_fixture()
      assert {:ok, %Github{} = github} = Accounts.update_github(github, @update_attrs)
      assert github.access_token == "some updated access_token"
      assert github.refresh_token == "some updated refresh_token"
    end

    test "update_github/2 with invalid data returns error changeset" do
      github = github_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_github(github, @invalid_attrs)
      assert github == Accounts.get_github!(github.id)
    end

    test "delete_github/1 deletes the github" do
      github = github_fixture()
      assert {:ok, %Github{}} = Accounts.delete_github(github)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_github!(github.id) end
    end

    test "change_github/1 returns a github changeset" do
      github = github_fixture()
      assert %Ecto.Changeset{} = Accounts.change_github(github)
    end
  end
end
