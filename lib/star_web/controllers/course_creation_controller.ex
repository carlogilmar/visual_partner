defmodule StarWeb.CourseCreationController do
  use StarWeb, :controller

  def index(conn, params) do
    conn |> render("index.html", course: params["id"])
  end
end
