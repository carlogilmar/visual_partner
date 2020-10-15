defmodule Star.UserOperator do
  @moduledoc """
  User operator definition
  """
  import Ecto.Query, only: [from: 2]
  alias Star.Repo
  alias Star.User

  def create_user(email, name, password, role) do
    email_in_db = get_by_email(email)

    case email_in_db do
      nil ->
        hash = hash_password(password)

        %User{}
        |> User.changeset(%{
          identifier: Ecto.UUID.generate(),
          email: email,
          name: name,
          password: hash,
          role: role
        })
        |> Repo.insert()

      user ->
        {:error, user}
    end
  end

  def get_all_by_role(role) do
    query = from(user in User, where: user.role == ^role, order_by: [desc: user.inserted_at])
    query |> Repo.all() |> Repo.preload([:definition])
  end

  def get_by_email(email) do
    query = from(user in User, where: user.email == ^email)
    query |> Repo.one()
  end

  def get_by_identifier(identifier) do
    query = from(user in User, where: user.identifier == ^identifier)
    query |> Repo.one()
  end

  def get_by_recover_hash(identifier) do
    query = from(user in User, where: user.recover_hash == ^identifier)
    query |> Repo.one()
  end

  def get_by_id(id), do: Repo.get(User, id)

  defp hash_password(password), do: Argon2.hash_pwd_salt(password)

  def delete_user(user_id) do
    user = get_by_id(user_id)
    Repo.delete(user)
  end

  def update(id, attrs) do
    model = get_by_id(id)

    model
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def complete_register(id, name, password) do
    hash = hash_password(password)

    update(
      id,
      %{status: "ACTIVE", name: name, password: hash}
    )
  end

  def update_password(id, password) do
    hash = hash_password(password)

    update(
      id,
      %{password: hash}
    )
  end
end
