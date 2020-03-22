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
    artwork_type = get_artwork_type(type)
    type = String.upcase(type)
    galleries = GalleryOperator.find_by_status(true, type)
    socket = socket |> assign(:galleries, galleries) |> assign(:type, artwork_type)

    {:noreply, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  defp get_artwork_type(type) do
    types = %{
      "partnership" => "Visual Partnership",
      "funny" => "Visual Stuff",
      "community" => "Communtiy",
      "event" => "Eventos",
      "meetings" => "Meetings",
      "resources" => "Learning"
    }

    case types[type] do
      nil -> "@visual_partner"
      artwork -> artwork
    end
  end
end
