defmodule Star.DefinitionOperator do
  import Ecto.Query, only: [from: 2]
  alias Star.UserOperator
  alias Star.Definition
  alias Star.Repo

  def create(description, user_id) do
    user = UserOperator.get_by_id(user_id)

    %Definition{
      description: description,
      user: user
    }
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Definition, id)
  end

  def get_all_by_user_id(user_id) do
    query =
      from(n in Definition,
        where: n.user_id == ^user_id,
        order_by: [desc: n.inserted_at]
      )

    Repo.all(query)
  end

  def delete(id) do
    model = get_by_id(id)
    Repo.delete(model)
  end

  def update(id, attrs) do
    model = get_by_id(id)

    model
    |> Definition.changeset(attrs)
    |> Repo.update()
  end
end
