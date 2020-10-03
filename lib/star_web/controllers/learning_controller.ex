defmodule StarWeb.LearningController do
  use StarWeb, :controller
  alias Star.CourseSessionOperator
  alias Star.EnrollmentOperator

  def index(conn, _params) do
    user = conn.private[:guardian_default_resource]

    render(conn, "index.html",
      user: user
    )
  end
end
