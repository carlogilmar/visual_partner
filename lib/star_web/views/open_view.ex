defmodule StarWeb.OpenView do
  use StarWeb, :view
  alias Star.CalendarUtil

  def get_date(date) do
    date |> NaiveDateTime.to_date() |> CalendarUtil.get_spanish_date()
  end
end
