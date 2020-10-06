defmodule StarWeb.SessionController do
  use StarWeb, :controller
  alias Star.CourseOperator
  alias Star.EnrollmentManager

  def index(conn, %{"id" => id}) do
    id = String.to_integer(id)
    course = CourseOperator.get_by_id(id)
    render(conn, "index.html", course: course)
  end

  def enroll(conn, params) do
    course_session_id = String.to_integer(params["course_session_id"])
    email = params["email"]
    EnrollmentManager.send_enroll_email(email, course_session_id)
    render(conn, "register.html")
  end
end
