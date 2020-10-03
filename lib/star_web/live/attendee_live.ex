defmodule StarWeb.AttendeeLive do
  use Phoenix.LiveView
  alias StarWeb.AttendeeView
  alias Star.EnrollmentOperator

  def render(assigns) do
    AttendeeView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    base_url = Application.get_env(:star, :base_url)

    socket =
      socket
      |> assign(:base_url, base_url)

    {:ok, socket}
  end

  def handle_params(
        %{"enrollment_id" => enrollment_id, "user_id" => user_identifier},
        _url,
        socket
      ) do
    enrollment = EnrollmentOperator.get_by_id(String.to_integer(enrollment_id))

    enrollment =
      if enrollment.user.identifier == user_identifier do
        enrollment
      else
        %{
          status: "ERROR",
          course_session: %{
            course: %{
              title: "",
              cover_url:
                "https://res.cloudinary.com/carlogilmar/image/upload/v1601588436/visual_partner/IMG_0154_osxkwq.png"
            }
          }
        }
      end

    socket =
      socket
      |> assign(:enrollment, enrollment)
      |> assign(:user_identifier, user_identifier)

    {:noreply, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  def handle_event("attendee_course", %{}, socket) do
    {:ok, enrollment} =
      EnrollmentOperator.update(socket.assigns.enrollment.id, %{"status" => "READY"})

    socket =
      socket
      |> assign(:enrollment, enrollment)

    {:noreply, socket}
  end

  def handle_event("save", %{"enrollment" => enrollment}, socket) do
    updated = Map.put(enrollment, "status", "FINISHED")
    {:ok, enrollment} = EnrollmentOperator.update(socket.assigns.enrollment.id, updated)

    socket =
      socket
      |> assign(:enrollment, enrollment)

    {:noreply, socket}
  end
end
