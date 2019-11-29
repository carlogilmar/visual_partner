defmodule Star.Email do
  @moduledoc """
  This module is for create email structs
  """
  import Bamboo.Email

  def build(email, subject, body) do
    new_email()
    |> to(email)
    |> from("apprenticesjourney@gmail.com")
    |> subject(subject)
    |> html_body(body)
  end

end
