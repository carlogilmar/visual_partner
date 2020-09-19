defmodule StarWeb.CourseChannel do
  use Phoenix.Channel

  def join("course:join", %{"course" => course_id}, socket) do
    {:ok, %{msg: "Aqui  andamos al pèdo"}, socket}
  end

end
