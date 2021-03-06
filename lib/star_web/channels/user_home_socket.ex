defmodule StarWeb.UserHomeChannel do
  use Phoenix.Channel
  alias Star.UserOperator
  alias Star.DefinitionOperator

  def join("user_home:join", %{"user" => user}, socket) do
    user = UserOperator.get_by_identifier(user)
    identifiers = get_definitions(user.id)
    {:ok, %{definitions: identifiers}, socket}
  end

  def handle_in(
        "user_home:definitions",
        %{
          "tags" => tags,
          "user" => user,
          "city" => city,
          "country" => country,
          "description" => description
        },
        socket
      ) do
    user = UserOperator.get_by_identifier(user)
    save_definitions(tags, user)

    UserOperator.update(user.id, %{
      "country" => country,
      "city" => city,
      "description" => description
    })

    identifiers = get_definitions(user.id)
    {:reply, {:ok, %{definitions: identifiers}}, socket}
  end

  defp get_definitions(user_id) do
    identifiers = DefinitionOperator.get_all_by_user_id(user_id)
    Enum.into(identifiers, [], fn identifier -> %{label: identifier.description} end)
  end

  defp save_definitions(tags, user) do
    Enum.each(tags, fn %{"text" => desc, "tiClasses" => _class} ->
      DefinitionOperator.create(desc, user.id)
    end)
  end
end
