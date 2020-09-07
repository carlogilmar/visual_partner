defmodule Star.DeliverableOperator do
  alias Star.Deliverable
  alias Star.Repo

  def create(title) do
     %Deliverable{
       title: title
      }
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Deliverable, id)
  end

  def get_all do
    Repo.all(Deliverable)
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
