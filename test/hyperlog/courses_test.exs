defmodule Hyperlog.CoursesTest do
  use Hyperlog.DataCase

  alias Hyperlog.Courses

  describe "course" do
    alias Hyperlog.Courses.Course

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def course_fixture(attrs \\ %{}) do
      {:ok, course} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Courses.create_course()

      course
    end

    test "list_course/0 returns all course" do
      course = course_fixture()
      assert Courses.list_course() == [course]
    end

    test "get_course!/1 returns the course with given id" do
      course = course_fixture()
      assert Courses.get_course!(course.id) == course
    end

    test "create_course/1 with valid data creates a course" do
      assert {:ok, %Course{} = course} = Courses.create_course(@valid_attrs)
      assert course.description == "some description"
      assert course.name == "some name"
    end

    test "create_course/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Courses.create_course(@invalid_attrs)
    end

    test "update_course/2 with valid data updates the course" do
      course = course_fixture()
      assert {:ok, %Course{} = course} = Courses.update_course(course, @update_attrs)
      assert course.description == "some updated description"
      assert course.name == "some updated name"
    end

    test "update_course/2 with invalid data returns error changeset" do
      course = course_fixture()
      assert {:error, %Ecto.Changeset{}} = Courses.update_course(course, @invalid_attrs)
      assert course == Courses.get_course!(course.id)
    end

    test "delete_course/1 deletes the course" do
      course = course_fixture()
      assert {:ok, %Course{}} = Courses.delete_course(course)
      assert_raise Ecto.NoResultsError, fn -> Courses.get_course!(course.id) end
    end

    test "change_course/1 returns a course changeset" do
      course = course_fixture()
      assert %Ecto.Changeset{} = Courses.change_course(course)
    end
  end

  describe "chapter" do
    alias Hyperlog.Courses.Chapter

    @valid_attrs %{lessons: %{}, name: "some name"}
    @update_attrs %{lessons: %{}, name: "some updated name"}
    @invalid_attrs %{lessons: nil, name: nil}

    def chapter_fixture(attrs \\ %{}) do
      {:ok, chapter} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Courses.create_chapter()

      chapter
    end

    test "list_chapter/0 returns all chapter" do
      chapter = chapter_fixture()
      assert Courses.list_chapter() == [chapter]
    end

    test "get_chapter!/1 returns the chapter with given id" do
      chapter = chapter_fixture()
      assert Courses.get_chapter!(chapter.id) == chapter
    end

    test "create_chapter/1 with valid data creates a chapter" do
      assert {:ok, %Chapter{} = chapter} = Courses.create_chapter(@valid_attrs)
      assert chapter.lessons == %{}
      assert chapter.name == "some name"
    end

    test "create_chapter/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Courses.create_chapter(@invalid_attrs)
    end

    test "update_chapter/2 with valid data updates the chapter" do
      chapter = chapter_fixture()
      assert {:ok, %Chapter{} = chapter} = Courses.update_chapter(chapter, @update_attrs)
      assert chapter.lessons == %{}
      assert chapter.name == "some updated name"
    end

    test "update_chapter/2 with invalid data returns error changeset" do
      chapter = chapter_fixture()
      assert {:error, %Ecto.Changeset{}} = Courses.update_chapter(chapter, @invalid_attrs)
      assert chapter == Courses.get_chapter!(chapter.id)
    end

    test "delete_chapter/1 deletes the chapter" do
      chapter = chapter_fixture()
      assert {:ok, %Chapter{}} = Courses.delete_chapter(chapter)
      assert_raise Ecto.NoResultsError, fn -> Courses.get_chapter!(chapter.id) end
    end

    test "change_chapter/1 returns a chapter changeset" do
      chapter = chapter_fixture()
      assert %Ecto.Changeset{} = Courses.change_chapter(chapter)
    end
  end
end
