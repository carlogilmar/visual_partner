defmodule Star.EnrollmentOperator do
  import Ecto.Query, only: [from: 2]
  alias Star.CourseSessionOperator
  alias Star.UserOperator
  alias Star.Enrollment
  alias Star.Repo

  def create(
        %{
          "detonator" => detonator,
          "expectations" => expectations,
          "location" => location,
          "occupation" => occupation
        },
        course_session_id,
        user_identifier
      ) do
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
    Repo.get(Enrollment, id) |> Repo.preload([:user, course_session: [:course]])
  end

  def get_by_course_session_and_user(course_session_id, user_identifier) do
    user = UserOperator.get_by_identifier(user_identifier)

    query =
      from(e in Enrollment,
        where: e.user_id == ^user.id and e.course_session_id == ^course_session_id
      )

    query |> Repo.one()
  end

  def get_all_by_user_and_status(user_id, status) do
    query = from(e in Enrollment, where: e.user_id == ^user_id)
    enrollments = query |> Repo.all() |> Repo.preload(course_session: [:course])
    Enum.filter(enrollments, fn enrollment -> enrollment.course_session.status == status end)
  end

  def get_all do
    Repo.all(Enrollment)
  end

  def get_all(user_id, status) do
    query = from(e in Enrollment, where: e.user_id == ^user_id and e.status == ^status)
    query |> Repo.all() |> Repo.preload(course_session: [:course])
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
