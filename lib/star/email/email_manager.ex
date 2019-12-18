defmodule Star.EmailManager do
  @moduledoc """
  This module is for send emails with attached file
  """
  alias Star.Email
  alias Star.Mailer

  def send_email(emailer, email) do
    email
    |> Email.build(emailer.title, emailer.content)
    |> Mailer.deliver_now()
  end
end
