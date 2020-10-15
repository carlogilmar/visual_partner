defmodule StarWeb.UsersLive do
  use Phoenix.LiveView
  alias Star.DefinitionOperator
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

  def handle_event("show_active_users", %{}, socket) do
    users = get_users("ACTIVE")
    socket = assign(socket, :users, users)
    {:noreply, socket}
  end

  def handle_event("show_inactive_users", %{}, socket) do
    users = get_users("INACTIVE")
    socket = assign(socket, :users, users)
    {:noreply, socket}
  end

  def handle_event("show_all_users", %{}, socket) do
    users = get_users("ALL")
    socket = assign(socket, :users, users)
    {:noreply, socket}
  end

  def handle_event("delete", %{"user_id" => user_id}, socket) do
    user_id = String.to_integer(user_id)
    {:ok, _user_deleted} = UserOperator.delete_user(user_id)
    socket = update_users(socket)
    {:noreply, socket}
  end

  def handle_event("delete_tag", %{"tag_id" => id}, socket) do
    tag_id = String.to_integer(id)
    {:ok, _user_deleted} = DefinitionOperator.delete(tag_id)
    socket = update_users(socket)
    {:noreply, socket}
  end

  def handle_event("save", %{"user" => %{"email" => email}}, socket) do
    _ = SignupManager.invite_user(email)
    socket = update_users(socket)
    {:noreply, socket}
  end

  defp get_users(status) do
    users = UserOperator.get_all_by_role("USER")

    case status do
      "ALL" ->
        users

      status ->
        Enum.filter(users, fn user -> user.status == status end)
    end
  end

  defp update_users(socket) do
    users = get_users("ALL")

    socket
    |> assign(:users, users)
  end
end
