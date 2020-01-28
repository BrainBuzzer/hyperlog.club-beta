defmodule Hyperlog.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Hyperlog.Repo
  alias Hyperlog.Profile

  alias Hyperlog.Accounts.User
  alias Hyperlog.Accounts.Role

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User) |> Repo.preload(:discord)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id) |> Repo.preload([:discord, :github, :projects, :roles, :profile])

  def get_user_by_username(username), do: Repo.get_by(User, username: username) |> Repo.preload([:projects, :roles])

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(id)
      {:ok, %User{}}

      iex> delete_user(id)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(id) do
    get_user!(id)
    |> Repo.delete()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def get_user_by_email(%{email: email}) do
    case Repo.get_by(User, %{email: email}) |> Repo.preload(:discord) do
      user = %User{} -> {:ok, user}
      nil -> {:error, :user_not_found}
    end
  end

  alias Hyperlog.Accounts.Discord

  @doc """
  Returns the list of user_discord.

  ## Examples

      iex> list_user_discord()
      [%Discord{}, ...]

  """
  def list_user_discord do
    Repo.all(Discord)
  end

  @doc """
  Gets a single discord.

  Raises `Ecto.NoResultsError` if the Discord does not exist.

  ## Examples

      iex> get_discord!(123)
      %Discord{}

      iex> get_discord!(456)
      ** (Ecto.NoResultsError)

  """
  def get_discord!(id), do: Repo.get!(Discord, id)

  @doc """
  Creates a discord.

  ## Examples

      iex> create_discord(%{field: value})
      {:ok, %Discord{}}

      iex> create_discord(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_discord(attrs \\ %{}) do
    %Discord{}
    |> Discord.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a discord.

  ## Examples

      iex> update_discord(discord, %{field: new_value})
      {:ok, %Discord{}}

      iex> update_discord(discord, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_discord(%Discord{} = discord, attrs) do
    discord
    |> Discord.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Discord.

  ## Examples

      iex> delete_discord(discord)
      {:ok, %Discord{}}

      iex> delete_discord(discord)
      {:error, %Ecto.Changeset{}}

  """
  def delete_discord(%Discord{} = discord) do
    Repo.delete(discord)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking discord changes.

  ## Examples

      iex> change_discord(discord)
      %Ecto.Changeset{source: %Discord{}}

  """
  def change_discord(%Discord{} = discord) do
    Discord.changeset(discord, %{})
  end

  def connect_discord(%User{} = user, auth) do
    user = Repo.preload(user, :profile)
    Profile.add_achievement_to_user(user.profile.id, "connect_discord")
    {:ok, user} = update_user(user, %{discord_connected: true})
    changeset = Ecto.build_assoc(user, :discord, %Discord{
      access_token: auth.credentials.token,
      refresh_token: auth.credentials.refresh_token,
      email: auth.info.email,
      discord_uid: auth.uid
    })
    Repo.insert! changeset
    {:ok, user}
  end

  def get_role!(id), do: Repo.get(Role, id)

  def get_role_discord_id!(discord_id), do: Repo.get_by!(Role, discord_id: discord_id)

  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  def list_roles(), do: Repo.all(Role)

  def assign_role_to_user(%User{} = user, role_id) do
    roles = Enum.map(role_id, fn id -> get_role_discord_id!(id) end)
    {:ok, user} = delete_roles_from_user(user)
    user
    |> Repo.preload([:roles, :discord])
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:roles, roles)
    |> Repo.update()
  end

  def delete_roles_from_user(%User{} = user) do
    user
    |> Repo.preload([:roles, :discord])
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:roles, [])
    |> Repo.update
  end

  alias Hyperlog.Accounts.Github

  @doc """
  Returns the list of github.

  ## Examples

      iex> list_github()
      [%Github{}, ...]

  """
  def list_github do
    Repo.all(Github)
  end

  @doc """
  Gets a single github.

  Raises `Ecto.NoResultsError` if the Github does not exist.

  ## Examples

      iex> get_github!(123)
      %Github{}

      iex> get_github!(456)
      ** (Ecto.NoResultsError)

  """
  def get_github!(id), do: Repo.get!(Github, id)

  @doc """
  Creates a github.

  ## Examples

      iex> create_github(%{field: value})
      {:ok, %Github{}}

      iex> create_github(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_github(attrs \\ %{}) do
    %Github{}
    |> Github.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a github.

  ## Examples

      iex> update_github(github, %{field: new_value})
      {:ok, %Github{}}

      iex> update_github(github, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_github(%Github{} = github, attrs) do
    github
    |> Github.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Github.

  ## Examples

      iex> delete_github(github)
      {:ok, %Github{}}

      iex> delete_github(github)
      {:error, %Ecto.Changeset{}}

  """
  def delete_github(%Github{} = github) do
    Repo.delete(github)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking github changes.

  ## Examples

      iex> change_github(github)
      %Ecto.Changeset{source: %Github{}}

  """
  def change_github(%Github{} = github) do
    Github.changeset(github, %{})
  end

  def link_user_with_github(user, token) do
    user = Repo.preload(user, :profile)
    Profile.add_achievement_to_user(user.profile.id, "connect_github")
    {:ok, user} = update_user(user, %{github_connected: true})
    changeset = Ecto.build_assoc(user, :github, %Github{
      access_token: token
    })
    Repo.insert! changeset
    {:ok, user}
  end
end
