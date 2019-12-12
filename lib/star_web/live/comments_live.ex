defmodule StarWeb.CommentsLive do

  use Phoenix.LiveView
  alias StarWeb.CommentsView

  def render(assigns) do
    CommentsView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

end
