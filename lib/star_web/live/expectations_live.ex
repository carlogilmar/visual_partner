defmodule StarWeb.ExpectationsLive do
  use Phoenix.LiveView
  alias StarWeb.ExpectationsView
  alias Star.CourseSessionOperator

  def render(assigns) do
    ExpectationsView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    course_session_id = String.to_integer(id)

    socket =
      socket
      |> assign(:course_session_id, course_session_id)

    socket = update_socket(socket)

    {:noreply, socket}
  end

  defp update_socket(socket) do
    course_session = CourseSessionOperator.get_by_id(socket.assigns.course_session_id)

    answers =
      Enum.reduce(
        course_session.enrollment,
        %{locations: [], expectations: [], occupations: [], detonators: []},
        fn enrollment, acc ->
          locations = acc.locations ++ [enrollment.location]
          expectations = acc.expectations ++ [enrollment.expectations]
          occupations = acc.occupations ++ [enrollment.occupation]
          detonators = acc.detonators ++ [enrollment.detonator]

          %{
            locations: locations,
            expectations: expectations,
            occupations: occupations,
            detonators: detonators
          }
        end
      )

    socket
    |> assign(:answers, answers)
  end

  def handle_event("redirect_url", %{}, socket) do
    uri = "/admin/course_session/#{socket.assigns.course_session.course.id}"
    {:noreply, live_redirect(socket, to: uri)}
  end
end
