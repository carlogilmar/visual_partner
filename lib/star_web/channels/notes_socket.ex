defmodule StarWeb.NotesChannel do
  use Phoenix.Channel
  alias Star.AnalyticsUtil

  def join("notes:join", _msg, socket) do
    {:ok, %{}, socket}
  end

end
