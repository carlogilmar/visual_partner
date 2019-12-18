defmodule StarWeb.SponsorsLive do
  use Phoenix.LiveView
  alias StarWeb.SponsorsView
  alias Star.Sponsorship
  alias Star.SponsorshipOperator
  alias Star.EmailerSenderOperator

  def render(assigns) do
    SponsorsView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    socket =
      socket
      |> assign(
        :changeset,
        Sponsorship.changeset(%Sponsorship{}, %{})
      )

    {:ok, socket}
  end

  def handle_event("save", %{"user" => params}, socket) do
    _ = SponsorshipOperator.create(params["email"], params["description"])
    _ = EmailerSenderOperator.send_sponsor_email(params["email"])
    {:noreply, live_redirect(socket, to: "/")}
  end
end
