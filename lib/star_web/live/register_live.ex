defmodule StarWeb.RegisterLive do

  use Phoenix.LiveView
  alias StarWeb.RegisterView

  def render(assigns) do
    RegisterView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => user_id}, _url, socket) do
    {:noreply, socket}
  end

end
