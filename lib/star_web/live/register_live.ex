defmodule StarWeb.RegisterLive do

  use Phoenix.LiveView
  alias StarWeb.RegisterView
  alias Star.UserOperator

  def render(assigns) do
    RegisterView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => user_uuid}, _url, socket) do
    user = UserOperator.get_by_identifier(user_uuid)
    socket = socket |> assign(:user, user)
    {:noreply, socket}
  end

end
