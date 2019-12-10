defmodule StarWeb.SponsorshipLive do

  use Phoenix.LiveView
  alias StarWeb.SponsorshipView
  alias Star.SponsorshipOperator

  def render(assigns) do
    SponsorshipView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    socket = update_socket(socket)
    {:ok, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  def handle_event("delete", %{"sponsor_id" => sponsor}, socket) do
    sponsor = String.to_integer(sponsor)
    _ = SponsorshipOperator.delete(sponsor)
    socket = update_socket(socket)
    {:noreply, socket}
  end

  defp update_socket(socket) do
    sponsors = SponsorshipOperator.get_all()

    socket
    |> assign(:sponsors, sponsors)
  end

end
