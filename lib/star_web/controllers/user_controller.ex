defmodule StarWeb.UserController do
  use StarWeb, :controller
  alias Star.CourseSessionOperator
  alias Star.EnrollmentOperator

  def index(conn, _params) do
    courses = CourseSessionOperator.get_all_by_status("OPEN")
    user = conn.private[:guardian_default_resource]
    enrollments_open = EnrollmentOperator.get_all_by_user_and_status(user.id, "OPEN")
    enrollments_in_course = EnrollmentOperator.get_all_by_user_and_status(user.id, "IN_COURSE")
    enrollments_ready = EnrollmentOperator.get_all_by_user_and_status(user.id, "READY")

    render(conn, "index.html",
      user: user,
      courses: courses,
      open: enrollments_open,
      ready: enrollments_ready,
      in_course: enrollments_in_course
    )
  end

  def delete(conn, %{"id" => id}) do
    id = String.to_integer(id)
    EnrollmentOperator.delete(id)

    conn
    |> redirect(to: "/dashboard")
  end
end
