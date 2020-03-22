defmodule StarWeb.EventLive do
  use Phoenix.LiveView
  alias Star.EventOperator
  alias StarWeb.EventView

  def render(assigns) do
    EventView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    socket = update_socket(socket)
    {:ok, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  def handle_event("save", %{"user" => params}, socket) do
    {:ok, _model} =
      EventOperator.create(
        params["title"],
        params["city"],
        params["url"],
        params["description"],
        params["date"]
      )

    socket = update_socket(socket)
    {:noreply, socket}
  end

  def handle_event("delete", %{"id" => model_id}, socket) do
    model_id = String.to_integer(model_id)
    {:ok, _model_deleted} = EventOperator.delete(model_id)
    socket = update_socket(socket)
    {:noreply, socket}
  end

  def handle_event("done_event", %{"id" => model_id}, socket) do
    model_id = String.to_integer(model_id)
    {:ok, _model} = EventOperator.update(model_id, %{status: false})
    socket = update_socket(socket)
    {:noreply, socket}
  end

  def handle_event("open_event", %{"id" => model_id}, socket) do
    model_id = String.to_integer(model_id)
    {:ok, _model} = EventOperator.update(model_id, %{status: true})
    socket = update_socket(socket)
    {:noreply, socket}
  end

  def handle_event("update_event_url", %{"user" => params}, socket) do
    model_id = String.to_integer(params["id"])
    params = %{url: params["url"]}
    {:ok, _model} = EventOperator.update(model_id, params)
    {:noreply, socket}
  end

  def handle_event("update_gallery_url", %{"user" => params}, socket) do
    model_id = String.to_integer(params["id"])
    params = %{gallery_url: params["url"]}
    {:ok, _model} = EventOperator.update(model_id, params)
    {:noreply, socket}
  end

  defp update_socket(socket) do
    models = EventOperator.get_all()

    socket
    |> assign(:models, models)
  end
end
