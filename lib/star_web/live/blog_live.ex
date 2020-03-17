defmodule StarWeb.BlogLive do

  use Phoenix.LiveView
  alias StarWeb.BlogView

  def render(assigns) do
    BlogView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

end
