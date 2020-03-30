defmodule StarWeb.TalksLive do
  use Phoenix.LiveView
  alias Star.TalkOperator
  alias StarWeb.TalksView

  def render(assigns) do
    TalksView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    socket = update_socket(socket)
    {:ok, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  def handle_event("new", %{"talk" => params}, socket) do
    {:ok, _model} = TalkOperator.create(params["title"], params["url"], params["cover"])
    socket = update_socket(socket)
    {:noreply, socket}
  end

  def handle_event("delete", %{"id" => model_id}, socket) do
    model_id = String.to_integer(model_id)
    {:ok, _model_deleted} = TalkOperator.delete(model_id)
    socket = update_socket(socket)
    {:noreply, socket}
  end

  def handle_event("to_publish", %{"id" => model_id}, socket) do
    model_id = String.to_integer(model_id)
    {:ok, _model} = TalkOperator.update(model_id, %{draft: true})
    socket = update_socket(socket)
    {:noreply, socket}
  end

  def handle_event("to_draft", %{"id" => model_id}, socket) do
    model_id = String.to_integer(model_id)
    {:ok, _model} = TalkOperator.update(model_id, %{draft: false})
    socket = update_socket(socket)
    {:noreply, socket}
  end

  defp update_socket(socket) do
    models = TalkOperator.get_all()

    socket
    |> assign(:models, models)
  end

end
