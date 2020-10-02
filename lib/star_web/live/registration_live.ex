defmodule StarWeb.RegistrationLive do

  use Phoenix.LiveView
  alias StarWeb.RegistrationView
  alias Star.CourseSessionOperator
  alias Star.EnrollmentOperator

  def render(assigns) do
    RegistrationView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"course_id" => course_session_id, "user_id" => user_identifier}, _url, socket) do
    course_session = CourseSessionOperator.get_by_id(String.to_integer(course_session_id))
    enrollment = EnrollmentOperator.get_by_course_session_and_user(course_session.id, user_identifier)

    socket =
      socket
      |> assign(:course_session_id, course_session_id)
      |> assign(:user_identifier, user_identifier)
      |> assign(:course_session, course_session)
      |> assign(:enrollment, enrollment)

    {:noreply, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  def handle_event("save", %{"enrollment" => params}, socket) do
    course_session_id = String.to_integer(socket.assigns.course_session_id)
    {:ok, _model} = EnrollmentOperator.create(params, course_session_id, socket.assigns.user_identifier)
    enrollment = EnrollmentOperator.get_by_course_session_and_user(course_session_id, socket.assigns.user_identifier)

    socket =
      socket
      |> assign(:enrollment, enrollment)

    {:noreply, socket}
  end

end
