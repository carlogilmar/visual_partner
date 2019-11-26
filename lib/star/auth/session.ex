defmodule Star.Session do
  @moduledoc false
  alias Star.UserOperator
  @user_not_found "Usuario no encontrado"
  @wrong_password "Password inválida"

  def auth_user(email, password) do
   email
    |> UserOperator.get_by_email()
    |> ensure_password(password)
  end

  def ensure_password(nil, _password), do: {:error, @user_not_found}

  def ensure_password(user, password) do
    password
    |> Argon2.verify_pass(user.password)
    |> auth_password_hash(user)
  end

  def auth_password_hash(true, user), do: {:ok, user}
  def auth_password_hash(false, _user), do: {:error, @wrong_password}
end
