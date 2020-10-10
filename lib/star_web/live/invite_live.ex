defmodule StarWeb.InviteLive do
  use Phoenix.LiveView
  alias StarWeb.InviteView
  alias Star.UserOperator
  alias Star.EmailerSenderOperator

  def render(assigns) do
    InviteView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => user_uuid}, _url, socket) do
    user = UserOperator.get_by_identifier(user_uuid)
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
        user = activate_user(params, socket.assigns.user)
        socket = socket |> assign(:user, user)
        {:noreply, socket}
    end
  end

  def activate_user(params, user) do
    {:ok, user} = UserOperator.complete_register(user.id, params["name"], params["password"])

    _ = EmailerSenderOperator.send_welcome_email(user.email)
    user
  end
end
