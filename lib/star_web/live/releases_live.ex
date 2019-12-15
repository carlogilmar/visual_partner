defmodule StarWeb.ReleasesLive do

  use Phoenix.LiveView
  alias StarWeb.ReleasesView

  def render(assigns) do
    ReleasesView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

end
