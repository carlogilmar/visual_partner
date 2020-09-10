defmodule StarWeb.CourseLive do
  use Phoenix.LiveView
  alias Star.CourseOperator
  alias StarWeb.CourseView

  def render(assigns) do
    CourseView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    socket = update_socket(socket)
    {:ok, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  def handle_event("new", _value, socket) do
    {:ok, email} = CourseOperator.create("Nuevo Curso")
    socket = update_socket(socket)
    {:noreply, socket}
  end

  def handle_event("delete", %{"id" => model_id}, socket) do
    model_id = String.to_integer(model_id)
    {:ok, _model_deleted} = CourseOperator.delete(model_id)
    socket = update_socket(socket)
    {:noreply, socket}
  end

  defp update_socket(socket) do
    models = CourseOperator.get_all()

    socket
    |> assign(:models, models)
  end

end
