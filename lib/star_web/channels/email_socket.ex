defmodule StarWeb.EmailChannel do
  @moduledoc """
  A module in charge of the analytics channel.
  """
  use Phoenix.Channel
  alias Star.EmailerOperator

  def join("email:join", %{"email" => email_id}, socket) do
    email_id = String.to_integer(email_id)
    email = EmailerOperator.get_by_id(email_id)
    {:ok, %{id: email.id, title: email.title, content: email.content}, socket}
  end

  def handle_in(
        "email:update",
        %{"attr" => attr, "id" => id, "value" => value},
        socket
      ) do
    attrs = Map.new([{String.to_atom(attr), value}])
    {:ok, _model} = EmailerOperator.update(id, attrs)
    {:reply, {:ok, %{status: "200"}}, socket}
  end

  def handle_in(
        "email:preview",
        %{"id" => id, "email" => email},
        socket
      ) do
    _ = EmailerOperator.send_preview(id, email)
    {:reply, {:ok, %{status: "200"}}, socket}
  end
end
