defmodule StarWeb.FeedbackLive do
  use Phoenix.LiveView
  alias StarWeb.FeedbackView
  alias Star.CourseSessionOperator

  def render(assigns) do
    FeedbackView.render("index.html", assigns)
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

    answers_accumulator = %{
      finished: [],
      rate: [],
      favourites: [],
      worst: [],
      instructor_feedback: [],
      comments: []
    }

    answers =
      Enum.reduce(course_session.enrollment, answers_accumulator, fn enrollment, acc ->
        finished = answers_accumulator.finished ++ [enrollment.finished]
        rate = answers_accumulator.rate ++ [enrollment.rate]
        favourites = answers_accumulator.favourites ++ [enrollment.favourites]
        worst = answers_accumulator.worst ++ [enrollment.worst]

        instructor_feedback =
          answers_accumulator.instructor_feedback ++ [enrollment.instructor_feedback]

        comments = answers_accumulator.comments ++ [enrollment.comments]

        %{
          finished: finished,
          rate: rate,
          favourites: favourites,
          worst: worst,
          instructor_feedback: instructor_feedback,
          comments: comments
        }
      end)

    socket
    |> assign(:answers, answers)
  end

  def handle_event("redirect_url", %{}, socket) do
    uri = "/admin/course_session/#{socket.assigns.course_session.course.id}"
    {:noreply, live_redirect(socket, to: uri)}
  end
end
