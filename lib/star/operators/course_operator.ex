defmodule Star.CourseOperator do
  alias Star.Course
  alias Star.Repo

  def create(title) do
    %Course{
      title: title
    }
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Course, id) |> Repo.preload([:course_session])
  end

  def get_all do
    Repo.all(Course)
  end

  def delete(id) do
    model = get_by_id(id)
    Repo.delete(model)
  end

  def update(id, attrs) do
    model = get_by_id(id)

    model
    |> Course.changeset(attrs)
    |> Repo.update()
  end
end
