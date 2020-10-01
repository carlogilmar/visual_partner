defmodule StarWeb.SessionChannel do
	use Phoenix.Channel
	alias Star.CourseOperator
	alias Star.CourseSessionOperator

	def join("session:join", %{"course" => id}, socket) do
		course_id = String.to_integer(id)
		course = CourseOperator.get_by_id(course_id)
		sessions = get_course_sessions(course)
		{:ok, %{sessions: sessions, title: course.title}, socket}
	end

	def handle_in(
		"session:new",
		%{"course" => course_id},
		socket
	) do
		course_id = String.to_integer(course_id)
		CourseSessionOperator.create(course_id)
		course = CourseOperator.get_by_id(course_id)
		sessions = get_course_sessions(course)
		{:reply, {:ok, %{sessions: sessions}}, socket}
	end

	def handle_in(
		"session:show",
		%{"session" => session_id},
		socket
	) do
		session =
			session_id
			|> CourseSessionOperator.get_by_id()
			|> get_session()
		{:reply, {:ok, %{session: session}}, socket}
	end

	def handle_in(
		"session:update",
		%{"attr" => attr, "id" => id, "value" => value},
		socket
	) do
		attrs = Map.new([{String.to_atom(attr), value}])
		{:ok, _model} = CourseSessionOperator.update(id, attrs)
		{:reply, {:ok, %{}}, socket}
	end

	defp get_session(session) do
		%{
			id: session.id,
			type: session.type,
			session_date: session.session_date,
			feedback: session.feedback
		}
	end

	defp get_course_sessions(course) do
		Enum.into(course.course_session, [], fn session ->
			%{
				id: session.id,
				type: session.type,
				session_date: parse_date(session.session_date)
			}
		end)
	end

	defp parse_date(nil) do
		"Por definir fecha"
	end

	defp parse_date(date) do
		date
		|> NaiveDateTime.to_date()
		|> Date.to_string()
	end

end
