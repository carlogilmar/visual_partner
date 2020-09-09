defmodule Star.DeliverableOperator do
  import Ecto.Query, only: [from: 2]
  alias Star.Deliverable
  alias Star.Repo

  def create(title) do
     %Deliverable{
       title: title
      }
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Deliverable, id) |> Repo.preload([:illustration])
  end

  def get_all do
    query = from(n in Deliverable, order_by: [desc: n.inserted_at])
    Repo.all(query)
  end

  def delete(id) do
    model = get_by_id(id)
    Repo.delete(model)
  end

  def update(id, attrs) do
    model = get_by_id(id)

    model
    |> Deliverable.changeset(attrs)
    |> Repo.update()
  end

end
