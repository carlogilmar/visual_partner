defmodule StarWeb.EmailChannel do
  @moduledoc """
  A module in charge of the analytics channel.
  """
  use Phoenix.Channel

  def join("email:join", _msg, socket) do
    {:ok, %{}, socket}
  end

end
