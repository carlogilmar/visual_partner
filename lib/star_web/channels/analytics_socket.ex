defmodule StarWeb.AnalyticsChannel do
  @moduledoc """
  A module in charge of the analytics channel.
  """
  use Phoenix.Channel

  def join("analytics:join", _msg, socket) do
    {:ok, %{}, socket}
  end

end
