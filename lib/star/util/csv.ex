defmodule Star.Csv do
  @moduledoc false
  alias Star.RegisterOperator
  alias Star.CourseSessionOperator

  def export_preregisters_from_cs(cs_id) do
    pre_registers = RegisterOperator.get_all_by_course_session(cs_id)
    rows = Enum.into(pre_registers, [], fn e -> [e.email, e.status, e.user_status] end)
    get_csv(rows)
  end

  def export_registers_from_cs(cs_id) do
    course_session = CourseSessionOperator.get_by_id(cs_id)
    rows = Enum.into(course_session.enrollment, [], fn e -> [e.user.email] end)
    get_csv(rows)
  end

  defp get_csv(content) do
    content
    |> CSV.encode()
    |> Enum.to_list()
    |> to_string()
  end
end
