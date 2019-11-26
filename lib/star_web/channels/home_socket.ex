defmodule StarWeb.HomeChannel do
  @moduledoc """
  A module in charge of the analytics channel.
  """
  use Phoenix.Channel

  def join("home:join", _msg, socket) do
    {:ok, %{}, socket}
  end
end
