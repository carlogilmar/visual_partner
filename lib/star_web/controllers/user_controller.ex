defmodule StarWeb.UserController do
  use StarWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", user: conn.private[:guardian_default_resource])
  end
end
