defmodule StarWeb.ImagesController do
  use StarWeb, :controller
  alias Star.ImageOperator

  def index(conn, _params) do
    images = ImageOperator.get_all()
    conn |> render("index.html", images: images)
  end
end
