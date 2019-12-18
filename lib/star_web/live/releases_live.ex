defmodule StarWeb.ReleasesLive do
  use Phoenix.LiveView
  alias StarWeb.ReleasesView
  alias Star.GitHubManager

  def render(assigns) do
    ReleasesView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    socket = socket |> assign(:commits, GitHubManager.get_commits())
    {:ok, socket}
  end
end
