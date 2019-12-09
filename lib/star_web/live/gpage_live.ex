defmodule StarWeb.GpageLive do

  use Phoenix.LiveView
  alias StarWeb.GpageView
  alias Star.GalleryOperator

  def render(assigns) do
    GpageView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    socket = update(socket)
    {:ok, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  ##def handle_event("delete", %{"user_id" => user_id}, socket) do
  ##  user_id = String.to_integer(user_id)
  ##  {:ok, _user_deleted} = UserOperator.delete_user(user_id)
  ##  socket = update_users(socket)
  ##  {:noreply, socket}
  ##end

  def update(socket) do
    galleries = GalleryOperator.get_all()

    socket
    |> assign(:galleries, galleries)
  end

end
