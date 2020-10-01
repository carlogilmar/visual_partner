defmodule StarWeb.UserController do
  use StarWeb, :controller
  alias Star.CourseSessionOperator

  def index(conn, _params) do
    courses = CourseSessionOperator.get_all_by_status("OPEN")
    render(conn, "index.html", user: conn.private[:guardian_default_resource], courses: courses)
  end
end
