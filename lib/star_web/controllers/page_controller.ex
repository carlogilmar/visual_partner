defmodule StarWeb.PageController do
  use StarWeb, :controller
  alias Star.EventOperator
  alias Star.NoteOperator

  def index(conn, _params) do
    events = EventOperator.get_upcoming()
    posts = NoteOperator.get_lastest_posts()
    render(conn, "index.html", events: events, posts: posts)
  end
end
