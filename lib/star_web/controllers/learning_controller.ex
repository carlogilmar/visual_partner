defmodule StarWeb.LearningController do
  use StarWeb, :controller

  def index(conn, _params) do
    user = conn.private[:guardian_default_resource]
    render(conn, "index.html", user: user)
  end
end
