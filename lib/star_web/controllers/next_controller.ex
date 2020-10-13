defmodule StarWeb.NextController do
  use StarWeb, :controller
  alias Star.CourseSessionOperator

  def index(conn, _params) do
    courses = CourseSessionOperator.get_all_by_status("OPEN")
    user = conn.private[:guardian_default_resource]

    render(conn, "index.html",
      user: user,
      courses: courses
    )
  end
end
