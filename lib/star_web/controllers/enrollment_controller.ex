defmodule StarWeb.EnrollmentController do
  use StarWeb, :controller
  alias Star.CourseSessionOperator
  alias Star.EnrollmentOperator

  def index(conn, %{"id" => course_session_id}) do
    course_session_id = String.to_integer(course_session_id)
    user = conn.private[:guardian_default_resource]
    course_session = CourseSessionOperator.get_by_id(course_session_id)
    enrollment = EnrollmentOperator.get_by_course_session_and_user(course_session_id, user.identifier)
    render(conn, "index.html", user: user, course_session: course_session, enrollment: enrollment)
  end
end
