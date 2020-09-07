defmodule Star.TalkOperator do
  import Ecto.Query, only: [from: 2]
  alias Star.Talk
  alias Star.Repo

  def create(title, url, cover) do
    %Talk{
      title: title,
      url: url,
      cover: cover
    }
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Talk, id)
  end

  def get_all do
    Repo.all(Talk)
  end

  def get_published do
    query =
      from(n in Talk,
        where: n.draft == true,
        order_by: [desc: n.inserted_at]
      )

    query |> Repo.all()
  end

  def delete(id) do
    model = get_by_id(id)
    Repo.delete(model)
  end

  def update(id, attrs) do
    model = get_by_id(id)

    model
    |> Talk.changeset(attrs)
    |> Repo.update()
  end
end
