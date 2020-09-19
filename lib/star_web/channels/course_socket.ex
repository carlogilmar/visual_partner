defmodule StarWeb.CourseChannel do
  use Phoenix.Channel
  alias Star.CourseOperator

  def join("course:join", %{"course" => id}, socket) do
    course_id = String.to_integer(id)
    course = CourseOperator.get_by_id(course_id)
    course = get_course(course)
    {:ok, %{course: course}, socket}
  end

  def handle_in(
        "course:update",
        %{"attr" => attr, "id" => id, "value" => value},
        socket
      ) do
    attrs = Map.new([{String.to_atom(attr), value}])
    {:ok, _model} = CourseOperator.update(id, attrs)
    {:reply, {:ok, %{}}, socket}
  end

  defp get_course(course) do
    %{
      id: course.id,
      title: course.title,
      language: course.language,
      slides_url: course.slides_url,
      visual_guide_url: course.visual_guide_url,
      workbook_url: course.workbook_url,
      cover_url: course.cover_url,
      duration: course.duration,
      hours: course.hours,

      payment: course.payment,
      references: course.references,
      requirements: course.requirements,
      goals: course.goals,
      description: course.description,
    }
  end

end
