defmodule StarWeb.RegistrationLive do

  use Phoenix.LiveView
  alias StarWeb.RegistrationView
  alias Star.CourseSessionOperator

  def render(assigns) do
    RegistrationView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"course_id" => course_session_id, "user_id" => user_identifier}, _url, socket) do
    course_session = CourseSessionOperator.get_by_id(String.to_integer(course_session_id))
    socket =
      socket
      |> assign(:course_session_id, course_session_id)
      |> assign(:user_identifier, user_identifier)
      |> assign(:course_session, course_session)
    {:noreply, socket}
  end

  def handle_event("save", %{"enrollment" => params}, socket) do
    IO.inspect params
    IO.inspect socket
    {:noreply, live_redirect(socket, to: "/user")}
  end

end
