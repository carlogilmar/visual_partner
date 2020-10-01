defmodule StarWeb.UserView do
  use StarWeb, :view

  def get_date(date) do
    date |> NaiveDateTime.to_date() |> Date.to_string()
  end
end
