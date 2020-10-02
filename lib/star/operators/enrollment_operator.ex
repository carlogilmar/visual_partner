defmodule Star.EnrollmentOperator do
  import Ecto.Query, only: [from: 2]
  alias Star.CourseSessionOperator
  alias Star.UserOperator
  alias Star.Enrollment
  alias Star.Repo

  def create(%{"detonator" => detonator, "expectations" => expectations, "location" => location, "occupation" => occupation}, course_session_id, user_identifier) do
    course_session = CourseSessionOperator.get_by_id(course_session_id)
    user = UserOperator.get_by_identifier(user_identifier)

    %Enrollment{
      location: location,
      expectations: expectations,
      occupation: occupation,
      detonator: detonator,
      user: user,
      course_session: course_session
    }
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Enrollment, id)
  end

  def get_all do
    Repo.all(Enrollment)
  end

  def get_by_course_session_and_user(course_session_id, user_identifier) do
    user = UserOperator.get_by_identifier(user_identifier)
    query = from(e in Enrollment, where: e.user_id == ^user.id and e.course_session_id == ^course_session_id)
    query |> Repo.one()
  end

  def delete(id) do
    model = get_by_id(id)
    Repo.delete(model)
  end

  def update(id, attrs) do
    model = get_by_id(id)

    model
    |> Enrollment.changeset(attrs)
    |> Repo.update()
  end
end
