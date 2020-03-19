defmodule Star.EventOperator do
  import Ecto.Query, only: [from: 2]
  alias Star.Event
  alias Star.Repo

  def create(title, city, url, description, date_desc) do
     %Event{
       title: title,
       city: city,
       url: url,
       description: description,
       date_desc: date_desc
      }
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Event, id)
  end

  def get_all do
    query =
      from(n in Event,
        order_by: [desc: n.inserted_at]
      )

    query
    |> Repo.all()
  end

  def get_upcoming do
    query =
      from(n in Event,
        where: n.status == true,
        order_by: [desc: n.inserted_at]
      )

    query
    |> Repo.all()
  end

  def delete(id) do
    model = get_by_id(id)
    Repo.delete(model)
  end

  def update(id, attrs) do
    model = get_by_id(id)

    model
    |> Event.changeset(attrs)
    |> Repo.update()
  end

end
