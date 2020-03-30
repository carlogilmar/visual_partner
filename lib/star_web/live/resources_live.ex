defmodule StarWeb.ResourcesLive do
  use Phoenix.LiveView
  alias StarWeb.ResourcesView
  alias Star.TalkOperator

  def render(assigns) do
    ResourcesView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    talks = TalkOperator.get_published()
    socket = socket |> assign(:talks, talks)
    {:ok, socket}
  end

  def handle_event("open_resource", %{"uri_val" => uri_val}, socket) do
    talk = TalkOperator.get_by_id(String.to_integer(uri_val))
    {:ok, _model} = TalkOperator.update(talk.id, %{clicks: talk.clicks + 1})
    {:noreply, socket}
  end

end
