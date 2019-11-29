defmodule StarWeb.AnalyticsController do
  use StarWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
