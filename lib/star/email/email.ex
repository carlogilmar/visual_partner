defmodule Star.Email do
  @moduledoc """
  This module is for create email structs
  """
  import Bamboo.Email
  alias Bamboo.Attachment

  def build(email, subject, body) do
    new_email()
    |> to(email)
    |> from("apprenticesjourney@gmail.com")
    |> subject(subject)
    |> html_body(body)
  end

  def build_with_attach(email, subject, body) do
    new_email()
    |> to(email)
    |> from("info@taketherisk.mx")
    |> subject(subject)
    |> html_body(body)
  end
end
