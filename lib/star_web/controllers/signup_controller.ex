defmodule StarWeb.SignupController do
  use StarWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create_user(conn, _params) do
    render(conn, "index.html")
  end

  def login_user(conn, _params) do
    render(conn, "index.html")
  end
end
