defmodule StarWeb.GpageLive do
  use Phoenix.LiveView
  alias StarWeb.GpageView
  alias Star.GalleryOperator

  def render(assigns) do
    GpageView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    IO.inspect(socket)
    socket = update(socket)
    {:ok, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  def handle_event("new", _value, socket) do
    {:ok, gallery} =
      GalleryOperator.create(
        "Gallery",
        "https://res.cloudinary.com/carlogilmar/image/upload/v1575604448/apprentices_journey/wip_dsixew.png",
        "",
        ""
      )

    {:noreply, live_redirect(socket, to: "/admin/gallery/#{gallery.id}")}
  end

  def handle_event("delete", %{"gallery" => gallery}, socket) do
    gallery = String.to_integer(gallery)
    _ = GalleryOperator.delete(gallery)
    socket = update(socket)
    {:noreply, socket}
  end

  def handle_event("active", %{"gallery" => gallery}, socket) do
    gallery = String.to_integer(gallery)
    _ = GalleryOperator.update_gallery(gallery, %{status: true})
    socket = update(socket)
    {:noreply, socket}
  end

  def handle_event("inactive", %{"gallery" => gallery}, socket) do
    gallery = String.to_integer(gallery)
    _ = GalleryOperator.update_gallery(gallery, %{status: false})
    socket = update(socket)
    {:noreply, socket}
  end

  def update(socket) do
    galleries = GalleryOperator.get_all()

    socket
    |> assign(:galleries, galleries)
  end
end
