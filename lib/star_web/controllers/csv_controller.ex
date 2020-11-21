defmodule StarWeb.CsvController do
  use StarWeb, :controller
  alias Star.Csv

  def export_preregisters(conn, %{"id" => cs_id}) do
    cs_id = String.to_integer(cs_id)
    csv_content = Csv.export_preregisters_from_cs(cs_id)

    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"preregisters.csv\"")
    |> send_resp(200, csv_content)
  end

  def export_registers(conn, %{"id" => cs_id}) do
    cs_id = String.to_integer(cs_id)
    csv_content = Csv.export_registers_from_cs(cs_id)

    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"registers.csv\"")
    |> send_resp(200, csv_content)
  end
end
