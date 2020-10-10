defmodule Star.RegisterOperator do
  import Ecto.Query, only: [from: 2]
  alias Star.Register
  alias Star.Repo
  alias Star.CourseSessionOperator

  def create(email, course_session_id) do
    course_session = CourseSessionOperator.get_by_id(course_session_id)
     %Register{
       email: email,
       course_session: course_session
      }
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Register, id)
  end

  def get_all do
    Repo.all(Register)
  end

  def get_all_by_course_session(course_session_id) do
    query = from(n in Register, where: n.course_session_id == ^course_session_id, order_by: [desc: n.inserted_at])
    Repo.all(query)
  end

  def delete(id) do
    model = get_by_id(id)
    Repo.delete(model)
  end

end
