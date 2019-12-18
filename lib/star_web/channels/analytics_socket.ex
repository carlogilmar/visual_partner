defmodule StarWeb.AnalyticsChannel do
  @moduledoc """
  A module in charge of the analytics channel.
  """
  use Phoenix.Channel
  alias Star.AnalyticsUtil

  def join("analytics:join", _msg, socket) do
    {analytics, info, counter} = AnalyticsUtil.get_analytics()
    {:ok, %{analytics: analytics, counter: counter, info: info}, socket}
  end
end
