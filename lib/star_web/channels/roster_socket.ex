defmodule StarWeb.RosterChannel do
  use Phoenix.Channel

  def join("roster:join", _msg, socket) do
    {:ok, %{}, socket}
  end

end
