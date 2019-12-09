defmodule StarWeb.GalleryChannel do
  use Phoenix.Channel

  def join("gallery:join", _msg, socket) do
    {:ok, %{}, socket}
  end

end
