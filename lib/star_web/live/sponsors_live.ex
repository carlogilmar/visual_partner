defmodule StarWeb.SponsorsLive do

  use Phoenix.LiveView
  alias StarWeb.SponsorsView
  alias Star.Sponsorship

  def render(assigns) do
    SponsorsView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    socket =
      socket
      |> assign(
        :changeset,
        Sponsorship.changeset(%Sponsorship{}, %{}))
    {:ok, socket}
  end

  def handle_event("save", %{"user" => params}, socket) do
    IO.puts "************"
    IO.inspect params
    IO.puts "************"
    {:noreply, live_redirect(socket, to: "/")}
  end

end
