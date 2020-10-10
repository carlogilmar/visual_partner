defmodule StarWeb.OpenController do
  use StarWeb, :controller
  alias Star.CourseSessionOperator

  def index(conn, _params) do
    courses = CourseSessionOperator.get_all_by_status("OPEN")
    render(conn, "index.html", courses: courses)
  end
end
