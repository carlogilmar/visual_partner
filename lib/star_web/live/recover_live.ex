defmodule StarWeb.RecoverLive do
  use Phoenix.LiveView
  alias StarWeb.RecoverView
  alias Star.UserOperator

  def render(assigns) do
    RecoverView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => user_uuid}, _url, socket) do
    user = UserOperator.get_by_recover_hash(user_uuid)
    socket = socket |> assign(:user, user) |> assign(:error, "")
    {:noreply, socket}
  end

  def handle_event("save", %{"user" => params}, socket) do
    activate.({params["password"] == params["password_confirm"], params, socket})
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  defp activate() do
    fn
      {false, _params, socket} ->
        socket = socket |> assign(:error, "Passwords no coinciden")
        {:noreply, socket}

      {true, params, socket} ->
        user = change_password(params, socket.assigns.user)
        socket = socket |> assign(:user, user)
        {:noreply, live_redirect(socket, to: "/welcome")}
    end
  end

  def change_password(params, user) do
    {:ok, user} = UserOperator.update_password(user.id, params["password"])
    {:ok, user} = UserOperator.update(user.id, %{recover_hash: nil})
    user
  end
end
