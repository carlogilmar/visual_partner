defmodule StarWeb.SessionController do
  use StarWeb, :controller
  alias Star.CourseOperator

  def index(conn, %{"id" => id}) do
    id = String.to_integer(id)
    course = CourseOperator.get_by_id(id)
    render(conn, "index.html", course: course)
  end
end
