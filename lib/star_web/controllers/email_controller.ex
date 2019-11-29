defmodule StarWeb.EmailController do
  use StarWeb, :controller

  def index(conn, params) do
    conn |> render("index.html", email: params["id"])
  end
end
