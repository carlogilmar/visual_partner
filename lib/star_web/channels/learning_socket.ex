defmodule StarWeb.LearningChannel do
  use Phoenix.Channel
  alias Star.UserOperator
  alias Star.EnrollmentOperator
  alias Star.CalendarUtil

  def join("learning:join", %{"user_id" => user_identifier}, socket) do
    user = UserOperator.get_by_identifier(user_identifier)
    enrollments = get_enrollments(user.id)
    {:ok, %{enrollments: enrollments, user: get_user(user)}, socket}
  end

	defp get_user(user) do
		%{
			id: user.id,
			name: user.name,
			email: user.email
		}
	end

  defp get_enrollments(user_id) do
    enrollments = EnrollmentOperator.get_all(user_id, "FINISHED")

    Enum.into(enrollments, [], fn enrollment ->
      %{
        id: enrollment.id,
        title: enrollment.course_session.course.title,
        course_date: CalendarUtil.get_spanish_date(enrollment.course_session.session_date),
        cover_url: enrollment.course_session.course.cover_url,
        slides_url: enrollment.course_session.course.slides_url,
        references: enrollment.course_session.course.references
      }
    end)
  end
end
