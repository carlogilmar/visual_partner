defmodule Star.UserOperator do
  @moduledoc """
  User operator definition
  """
  import Ecto.Query, only: [from: 2]
  alias Star.Repo
  alias Star.User

  def create_user(email, name, password, role) do
    hash = hash_password(password)

    %User{}
    |> User.changeset(%{email: email, name: name, password: hash, role: role})
    |> Repo.insert()
  end

  def get_by_email(email) do
    query = from(user in User, where: user.email == ^email)
    query |> Repo.one()
  end

  def get_by_id(id), do: Repo.get(User, id)

  defp hash_password(password), do: Argon2.hash_pwd_salt(password)

  def delete_user(user_id) do
    user = get_by_id(user_id)
    Repo.delete(user)
  end
end
