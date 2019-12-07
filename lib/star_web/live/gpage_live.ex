defmodule StarWeb.GpageLive do

  use Phoenix.LiveView
  alias StarWeb.GpageView

  def render(assigns) do
    GpageView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

end
