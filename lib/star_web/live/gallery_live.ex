defmodule StarWeb.GalleryLive do

  use Phoenix.LiveView
  alias StarWeb.GalleryView

  def render(assigns) do
    GalleryView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

end
