defmodule StarWeb.ProfileLive do
  use Phoenix.LiveView
  alias StarWeb.ProfileView
  alias Star.DefinitionOperator
  alias Star.UserOperator
  alias Star.Session

  def render(assigns) do
    ProfileView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(
        %{"user_id" => user_identifier},
        url,
        socket
      ) do
    user = UserOperator.get_by_identifier(user_identifier)
    identifiers = DefinitionOperator.get_all_by_user_id(user.id)

    socket =
      socket
      |> assign(:user, user)
      |> assign(:msg, "")
      |> assign(:identifiers, identifiers)

    {:noreply, socket}
  end

  def handle_event("save_name", %{"user" => name}, socket) do
    {:ok, user} = UserOperator.update(socket.assigns.user.id, name)

    socket =
      socket
      |> assign(:user, user)
      |> assign(:msg, "Email actualizado")

    {:noreply, socket}
  end

  def handle_event("save_email", %{"user" => params}, socket) do
    case UserOperator.get_by_email(params["email"]) do
      nil ->
        {:ok, user} = UserOperator.update(socket.assigns.user.id, params)

        socket =
          socket
          |> assign(:user, user)
          |> assign(:msg, "Email actualizado")

        {:noreply, socket}

      _other ->
        socket =
          socket
          |> assign(:msg, "No se puede actualizar email a #{params["email"]}")

        {:noreply, socket}
    end
  end

  def handle_event("save_password", %{"user" => params}, socket) do
    {user, msg} =
      params
      |> confirm_old_password(socket.assigns.user)
      |> confirm_new_password()
      |> update_password()

    socket =
      socket
      |> assign(:user, user)
      |> assign(:msg, msg)

    {:noreply, socket}
  end

  def handle_event("redirect_url", %{"uri_val" => uri_val}, socket) do
    {:noreply, live_redirect(socket, to: uri_val)}
  end

  def handle_event("delete_identifier", %{"id" => identifier}, socket) do
    id = String.to_integer(identifier)
    DefinitionOperator.delete(id)
    user = socket.assigns.user
    identifiers = DefinitionOperator.get_all_by_user_id(user.id)
    socket = assign(socket, :identifiers, identifiers)
    {:noreply, socket}
  end

  def handle_event("save_identifier", %{"identifier" => %{"description" => description}}, socket) do
    user = socket.assigns.user
    DefinitionOperator.create(description, user.id)
    identifiers = DefinitionOperator.get_all_by_user_id(user.id)
    socket = assign(socket, :identifiers, identifiers)
    {:noreply, socket}
  end

  defp confirm_old_password(params, user) do
    case Session.ensure_password(user, params["password"]) do
      {:ok, _user} ->
        {:ok, params, user}

      {:error, msg} ->
        {:error, msg, user}
    end
  end

  defp confirm_new_password({:ok, params, user}) do
    case params["new"] == params["confirm"] do
      true ->
        {:ok, params, user}

      false ->
        {:error, "Password nueva y confirmaciòn no coincide", user}
    end
  end

  defp confirm_new_password({:error, msg, user}) do
    {:error, msg, user}
  end

  defp update_password({:ok, params, user}) do
    {:ok, user} = UserOperator.update_password(user.id, params["new"])
    {user, "Password actualizada"}
  end

  defp update_password({:error, msg, user}) do
    {user, msg}
  end
end
