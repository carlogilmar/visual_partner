defmodule StarWeb.NoteController do
  use StarWeb, :controller

  def index(conn, params) do
    conn |> render("index.html", note: params["id"])
  end
end
