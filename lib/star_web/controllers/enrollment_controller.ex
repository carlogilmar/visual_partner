defmodule StarWeb.EnrollmentController do
  use StarWeb, :controller
  alias Star.CourseSessionOperator

  def index(conn, %{"id" => course_session_id}) do
    course_session = CourseSessionOperator.get_by_id(String.to_integer(course_session_id))
    render(conn, "index.html", user: conn.private[:guardian_default_resource], course_session: course_session)
  end
end
