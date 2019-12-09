defmodule StarWeb.BundleController do
  use StarWeb, :controller

  def index(conn, params) do
    conn |> render("index.html", gallery: params["id"])
  end
end
