defmodule StarWeb.SessionChannel do
  use Phoenix.Channel
  alias Star.CourseOperator
  alias Star.CourseSessionOperator

  def join("session:join", %{"course" => id}, socket) do
    course_id = String.to_integer(id)
    course = CourseOperator.get_by_id(course_id)
    sessions = get_course_sessions(course)
    {:ok, %{sessions: sessions}, socket}
  end

  def handle_in(
        "session:new",
        %{"course" => course_id},
        socket
      ) do
    course_id = String.to_integer(course_id)
    CourseSessionOperator.create(course_id)
    course = CourseOperator.get_by_id(course_id)
    sessions = get_course_sessions(course)
    {:reply, {:ok, %{sessions: sessions}}, socket}
  end

  def handle_in(
        "course:update",
        %{"attr" => attr, "id" => id, "value" => value},
        socket
      ) do
    attrs = Map.new([{String.to_atom(attr), value}])
    {:ok, _model} = CourseOperator.update(id, attrs)
    {:reply, {:ok, %{}}, socket}
  end

  defp get_course_sessions(course) do
    Enum.into(course.course_session, [], fn session ->
      %{
        id: session.id,
        type: session.type,
        session_date: session.session_date
      }
    end)
  end

end
