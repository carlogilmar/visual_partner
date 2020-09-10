defmodule StarWeb.ReviewLive do
  use Phoenix.LiveView
  alias Star.TaskOperator
  alias StarWeb.ReviewView
  alias StarWeb.Endpoint

  def render(assigns) do
    ReviewView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    Endpoint.subscribe("tasks")
    socket = update_socket(socket)
    {:ok, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  def handle_info(%{event: "update_dashboard", payload: %{}}, socket) do
    socket = update_socket(socket)
    {:noreply, socket}
  end

  defp update_socket(socket) do
    models = TaskOperator.get_all()

    socket
    |> assign(:models, models)
  end
end
