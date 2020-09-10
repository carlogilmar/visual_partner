defmodule Star.EnrollmentOperator do
  alias Star.CourseSessionOperator
  alias Star.UserOperator
  alias Star.Enrollment
  alias Star.Repo

  def create(user_id, course_session_id) do
    course_session = CourseSessionOperator.get_by_id(course_session_id)
    user = UserOperator.get_by_id(user_id)

    %Enrollment{
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
