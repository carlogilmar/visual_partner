defmodule StarWeb.UsersLive do
  use Phoenix.LiveView
  alias Star.UserOperator
  alias Star.SignupManager
  alias StarWeb.UsersView

  def render(assigns) do
    UsersView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    socket = update_users(socket)
    {:ok, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  def handle_event("delete", %{"user_id" => user_id}, socket) do
    user_id = String.to_integer(user_id)
    {:ok, _user_deleted} = UserOperator.delete_user(user_id)
    socket = update_users(socket)
    {:noreply, socket}
  end

  defp update_users(socket) do
    users = UserOperator.get_all_by_role("USER")

    socket
    |> assign(:users, users)
    |> assign(:total, length(users))
  end

  def handle_event("save", %{"user" => %{"email" => email}}, socket) do
    _ = SignupManager.invite_user(email)
    socket = update_users(socket)
    {:noreply, socket}
  end
end
