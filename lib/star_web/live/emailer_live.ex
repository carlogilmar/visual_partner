defmodule StarWeb.EmailerLive do
  use Phoenix.LiveView
  alias Star.EmailerOperator
  alias StarWeb.EmailerView

  def render(assigns) do
    EmailerView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    socket = update_socket(socket)
    {:ok, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  defp update_socket(socket) do
    emailers = EmailerOperator.get_all()

    socket
    |> assign(:emailers, emailers)
  end

end
