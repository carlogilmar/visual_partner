defmodule StarWeb.ProfileLive do
  use Phoenix.LiveView
  alias StarWeb.ProfileView
  alias Star.UserOperator

  def render(assigns) do
    ProfileView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(
        %{"user_id" => user_identifier},
        url,
        socket
      ) do
    user = UserOperator.get_by_identifier(user_identifier)
    socket = socket |> assign(:user, user)
    {:noreply, socket}
  end

  def handle_event("save_name", %{"user" => name}, socket) do
    {:ok, user} = UserOperator.update(socket.assigns.user.id, name)

    socket =
      socket
      |> assign(:user, user)

    {:noreply, socket}
  end
end
