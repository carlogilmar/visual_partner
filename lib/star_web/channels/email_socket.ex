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

end
