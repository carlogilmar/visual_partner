defmodule Star.EnrollmentManager do
  alias Star.EmailerSenderOperator
  alias Star.UserOperator
  alias Star.CourseSessionOperator
  @user_role "USER"

  def send_enroll_email(email, course_session_id) do
    email
    |> find_user_by_email()
    |> register_user()
    |> send_email(course_session_id)
  end

  defp find_user_by_email(email) do
    user = UserOperator.get_by_email(email)

    case user do
      nil -> {email, :to_create}
      _user -> user
    end
  end

  defp register_user({email, :to_create}) do
    {:ok, user} = UserOperator.create_user(email, "", "", @user_role)
    user
  end

  defp register_user(user) do
    user
  end

  defp send_email(user, course_session_id) do
    base_path = Application.get_env(:star, StarWeb.Endpoint)[:base_url]
    enrollment_url = "#{base_path}dashboard/enrollment/#{course_session_id}"
    course_session = CourseSessionOperator.get_by_id(course_session_id)

    case user.status do
      "INACTIVE" ->
        register_url = "#{base_path}register/#{user.identifier}"

        EmailerSenderOperator.send_register_email(
          user.email,
          register_url,
          enrollment_url,
          course_session.course.title
        )

        user

      "ACTIVE" ->
        EmailerSenderOperator.send_enrollment_email(
          user.email,
          enrollment_url,
          course_session.course.title
        )

        user
    end
  end
end
