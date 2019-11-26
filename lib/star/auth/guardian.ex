defmodule Star.Guardian do
  @moduledoc false
  use Guardian, otp_app: :scalathon
  alias Star.UserOperator

  def subject_for_token(user, _claims) do
    validate(user)
  end

  def validate({:ok, _session, claims}) do
    user_id = claims["sub"]
    {:ok, user_id}
  end

  def validate(user) do
    {:ok, user.id}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    user = UserOperator.get_by_id(id)
    {:ok, user}
  end
end
