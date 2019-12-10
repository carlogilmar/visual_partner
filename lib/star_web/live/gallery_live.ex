defmodule StarWeb.GalleryLive do

  use Phoenix.LiveView
  alias StarWeb.GalleryView
  alias Star.GalleryOperator

  def render(assigns) do
    GalleryView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    galleries = GalleryOperator.find_by_status(true)
    socket =  socket |> assign(:galleries, galleries)

    {:ok, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

end
