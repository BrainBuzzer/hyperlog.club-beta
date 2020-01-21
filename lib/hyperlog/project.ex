defmodule Hyperlog.Project do
  @moduledoc """
  The Project context.
  """

  import Ecto.Query, warn: false
  alias Hyperlog.Repo

  alias Hyperlog.Project.MetaData

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%MetaData{}, ...]

  """
  def list_projects do
    Repo.all(MetaData)
  end

  @doc """
  Gets a single meta_data.

  Raises `Ecto.NoResultsError` if the Meta data does not exist.

  ## Examples

      iex> get_meta_data!(123)
      %MetaData{}

      iex> get_meta_data!(456)
      ** (Ecto.NoResultsError)

  """
  def get_meta_data!(id), do: Repo.get!(MetaData, id)

  def get_projects_by_user_id(user_id), do: Repo.get_by(MetaData, user_id: user_id)

  @doc """
  Creates a meta_data.

  ## Examples

      iex> create_meta_data(%{field: value})
      {:ok, %MetaData{}}

      iex> create_meta_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_meta_data(attrs \\ %{}) do
    %MetaData{}
    |> MetaData.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a meta_data.

  ## Examples

      iex> update_meta_data(meta_data, %{field: new_value})
      {:ok, %MetaData{}}

      iex> update_meta_data(meta_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_meta_data(%MetaData{} = meta_data, attrs) do
    meta_data
    |> MetaData.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a MetaData.

  ## Examples

      iex> delete_meta_data(meta_data)
      {:ok, %MetaData{}}

      iex> delete_meta_data(meta_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_meta_data(%MetaData{} = meta_data) do
    Repo.delete(meta_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking meta_data changes.

  ## Examples

      iex> change_meta_data(meta_data)
      %Ecto.Changeset{source: %MetaData{}}

  """
  def change_meta_data(%MetaData{} = meta_data) do
    MetaData.changeset(meta_data, %{})
  end
end
