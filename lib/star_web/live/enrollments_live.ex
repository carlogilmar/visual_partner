defmodule StarWeb.EnrollmentsLive do
  use Phoenix.LiveView
  alias Star.CourseSessionOperator
  alias Star.EnrollmentOperator
  alias StarWeb.EnrollmentsView

  def render(assigns) do
    EnrollmentsView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    course_session_id = String.to_integer(id)

    socket =
      socket
      |> assign(:course_session_id, course_session_id)
      |> assign(:models, [])

    socket = update_socket(socket)

    {:noreply, socket}
  end

  defp update_socket(socket) do
    course_session = CourseSessionOperator.get_by_id(socket.assigns.course_session_id)

    counters =
      Enum.reduce(
        course_session.enrollment,
        %{"ENROLL" => 0, "READY" => 0, "FINISHED" => 0},
        fn e, acc ->
          counter = acc[e.status]
          Map.put(acc, e.status, counter + 1)
        end
      )

    socket
    |> assign(:course_session, course_session)
    |> assign(:enrollments, course_session.enrollment)
    |> assign(:counters, counters)
  end

  def handle_event("redirect_url", %{}, socket) do
    uri = "/admin/course_session/#{socket.assigns.course_session.course.id}"
    {:noreply, live_redirect(socket, to: uri)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    enrollment_id = String.to_integer(id)
    EnrollmentOperator.delete(enrollment_id)
    socket = update_socket(socket)
    {:noreply, socket}
  end
end
