defmodule StarWeb.DeliverableChannel do
  use Phoenix.Channel
  alias Star.DeliverableOperator

  def join("deliverable:join", %{}, socket) do
    {:ok, %{}, socket}
  end

end
