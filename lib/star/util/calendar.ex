defmodule Star.CalendarUtil do

  def get_spanish_date(date) do
    month = get_month(date.month)
    "#{date.day} de #{month}/#{date.year}"
  end

  defp get_month(month) do
    months = %{
      1 => "Enero",
      2 => "Febrero",
      3 => "Marzo",
      4 => "Abril",
      5 => "Mayo",
      6 => "Junio",
      7 => "Julio",
      8 => "Agosto",
      9 => "Septiembre",
      10 => "Octubre",
      11 => "Noviembre",
      12 => "Diciembre"
    }
    months[month]
  end

end
