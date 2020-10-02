defmodule Star.CourseSessionOperator do
  import Ecto.Query, only: [from: 2]
  alias Star.CourseOperator
  alias Star.CourseSession
  alias Star.Repo

  def create(course_id) do
    course = CourseOperator.get_by_id(course_id)

    %CourseSession{
      course: course
    }
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(CourseSession, id) |> Repo.preload([:course, :agenda_item, :promo_illustration])
  end

  def get_all do
    Repo.all(CourseSession)
  end

  def get_all_by_status(status) do
    query = from(n in CourseSession, where: n.status == ^status, order_by: [desc: n.inserted_at])
    Repo.all(query) |> Repo.preload([:course])
  end

  def delete(id) do
    model = get_by_id(id)
    Repo.delete(model)
  end

  def update(id, attrs) do
    model = get_by_id(id)

    model
    |> CourseSession.changeset(attrs)
    |> Repo.update()
  end
end
