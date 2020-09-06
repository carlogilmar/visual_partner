defmodule StarWeb.TasksChannel do
  use Phoenix.Channel

  def join("tasks:join", _msg, socket) do
    {:ok, %{}, socket}
  end
end
