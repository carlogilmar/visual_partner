defmodule StarWeb.HomeChannel do
  @moduledoc """
  A module in charge of the analytics channel.
  """
  use Phoenix.Channel
	alias Star.ViewerOperator

  def join("home:join", _msg, socket) do
    {:ok, %{}, socket}
  end

  def handle_in("home:session", session, socket) do
    _ = ViewerOperator.create_viewer(session)
    {:noreply, socket}
  end
end
