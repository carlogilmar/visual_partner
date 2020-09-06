defmodule Star.TaskOperator do
  import Ecto.Query, only: [from: 2]
  alias Star.Task
  alias Star.Repo

  def create(title, description) do
     %Task{
       title: title,
       description: description
      }
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Task, id)
  end

  def get_by_status(status) do
    query =
      from(n in Task,
        where: n.status == ^status,
        order_by: [desc: n.inserted_at]
      )

    Repo.all(query)
  end

  def get_all do
    query =
      from(n in Task,
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
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  def update(id, :to_do), do: update(id, %{status: "TO DO"})
  def update(id, :doing), do: update(id, %{status: "DOING"})
  def update(id, :done), do: update(id, %{status: "DONE"})

end
