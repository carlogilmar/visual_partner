defmodule StarWeb.GalleryLive do
  use Phoenix.LiveView
  alias StarWeb.GalleryView
  alias Star.GalleryOperator

  def render(assigns) do
    GalleryView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"type" => type}, _url, socket) do
    type = String.upcase(type)
    galleries = GalleryOperator.find_by_status(true, type)
    socket = socket |> assign(:galleries, galleries)

    {:noreply, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end
end
