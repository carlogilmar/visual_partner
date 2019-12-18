defmodule StarWeb.RegisterLive do
  use Phoenix.LiveView
  alias StarWeb.RegisterView
  alias Star.UserOperator
	alias Star.EmailerSenderOperator

  def render(assigns) do
    RegisterView.render("index.html", assigns)
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
		{:ok, user} =
			UserOperator.update(
				user.id,
				%{status: "ACTIVE",
					name: params["name"],
					password: params["password"]})
		_ = EmailerSenderOperator.send_welcome_email(user.email)
		user
	end

end
