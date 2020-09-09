defmodule Star.IllustrationOperator do
  alias Star.DeliverableOperator
  alias Star.Illustration
  alias Star.Repo

  def create(deliverable_id, title) do
    deliverable = DeliverableOperator.get_by_id(deliverable_id)
     %Illustration{
			 title: title,
       deliverable: deliverable
      }
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Illustration, id)
  end

  def get_all do
    Repo.all(Illustration)
  end

  def delete(id) do
    model = get_by_id(id)
    Repo.delete(model)
  end

  def update(id, attrs) do
    model = get_by_id(id)

    model
    |> Illustration.changeset(attrs)
    |> Repo.update()
  end

end
