defmodule StarWeb.PageController do
  use StarWeb, :controller
  alias Star.EventOperator
  alias Star.NoteOperator
  alias Star.GalleryOperator

  def index(conn, _params) do
    events = EventOperator.get_upcoming()
    posts = NoteOperator.get_lastest_posts()
    galleries = GalleryOperator.get_lastest()
    render(conn, "index.html", events: events, posts: posts, galleries: galleries)
  end
end
