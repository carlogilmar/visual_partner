defmodule StarWeb.BlogLive do
  use Phoenix.LiveView
  alias StarWeb.BlogView
  alias Star.NoteOperator

  def render(assigns) do
    BlogView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    socket = update_socket(socket)
    {:ok, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  defp update_socket(socket) do
    notes = NoteOperator.get_all_published()

    socket
    |> assign(:notes, notes)
  end
end
