defmodule StarWeb.UserView do
  use StarWeb, :view
  alias Star.CalendarUtil

  def get_date(date) do
    date |> NaiveDateTime.to_date() |> CalendarUtil.get_spanish_date()
  end

  def get_date_since(date) do
    "Miembro desde #{CalendarUtil.get_month(date.month)} de #{date.year}"
  end
end
