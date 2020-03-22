defmodule StarWeb.PageController do
  use StarWeb, :controller
  alias Star.EventOperator

  def index(conn, _params) do
    events = EventOperator.get_upcoming
    render(conn, "index.html", events: events)
  end
end
