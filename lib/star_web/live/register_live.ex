defmodule StarWeb.RegisterLive do
  use Phoenix.LiveView
  alias Star.EnrollmentManager
  alias Star.RegisterOperator
  alias StarWeb.RegisterView

  def render(assigns) do
    RegisterView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(
        %{"id" => course_session_id},
        _url,
        socket
      ) do
    course_session_id = String.to_integer(course_session_id)
    registers = RegisterOperator.get_all_by_course_session(course_session_id)

    socket =
      socket
      |> assign(:course_session_id, course_session_id)
      |> assign(:registers, registers)

    {:noreply, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  def handle_event("delete", %{"id" => model_id}, socket) do
    model_id = String.to_integer(model_id)
    {:ok, _model_deleted} = RegisterOperator.delete(model_id)
    socket = update_socket(socket)
    {:noreply, socket}
  end

  def handle_event("invite", %{"id" => register_id, "email" => email}, socket) do
    register_id = String.to_integer(register_id)
    EnrollmentManager.send_enroll_email(email, socket.assigns.course_session_id)
    RegisterOperator.update(register_id, %{status: "SENT"})
    socket = update_socket(socket)
    {:noreply, socket}
  end

  defp update_socket(socket) do
    course_session_id = socket.assigns.course_session_id
    registers = RegisterOperator.get_all_by_course_session(course_session_id)

    socket
    |> assign(:registers, registers)
  end
end
