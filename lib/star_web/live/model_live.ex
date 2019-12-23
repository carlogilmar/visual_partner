defmodule StarWeb.ModelLive do
  use Phoenix.LiveView
  alias Star.ModelOperator
  alias StarWeb.ModelView

  def render(assigns) do
    ModelView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    socket = update_socket(socket)
    {:ok, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  def handle_event("new", _value, socket) do
    {:ok, model} = ModelOperator.create("url", "esp", "eng")
    socket = update_socket(socket)
    {:noreply, socket}
  end

  def handle_event("delete", %{"id" => model_id}, socket) do
    model_id = String.to_integer(model_id)
    {:ok, _model_deleted} = ModelOperator.delete(model_id)
    socket = update_socket(socket)
    {:noreply, socket}
  end

  def handle_event("save", %{"user" => params}, socket) do
    {:ok, _model} = ModelOperator.create(params["title"], params["url"], params["esp_desc"], params["eng_desc"])
    socket = update_socket(socket)
    {:noreply, socket}
  end

  defp update_socket(socket) do
    models = ModelOperator.get_all()

    socket
    |> assign(:models, models)
  end

end
