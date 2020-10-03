defmodule StarWeb.LearningChannel do
  use Phoenix.Channel

  def join("learning:join", %{"user_id" => user_identifier}, socket) do
    {:ok, %{}, socket}
  end

end
