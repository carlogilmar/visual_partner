defmodule Star.NoteOperator do
  import Ecto.Query, only: [from: 2]
  alias Star.Note
  alias Star.Repo

  def create(body, title) do
    %Note{title: title, body: body, date_desc: "Sin Fecha"}
    |> Repo.insert()
  end

  def get_by_id(id) do
    Note |> Repo.get(id) |> Repo.preload([:comment_note])
  end

  def get_all do
    query =
      from(n in Note,
        order_by: [desc: n.inserted_at]
      )

    query
    |> Repo.all()
  end

  def get_all_published do
    query =
      from(n in Note,
        where: n.status == true,
        order_by: [desc: n.inserted_at]
      )

    query
    |> Repo.all()
  end

  def get_lastest_posts do
    query =
      from(n in Note,
        where: n.status == true,
        order_by: [desc: n.inserted_at]
      )

    notes = query |> Repo.all()

    case length(notes) do
      e when e in 0..3 -> notes
      _ -> Enum.take(notes, 3)
    end

  end

  def delete(id) do
    note = get_by_id(id)
    Repo.delete(note)
  end

  def update(id, attrs) do
    note = get_by_id(id)

    note
    |> Note.changeset(attrs)
    |> Repo.update()
  end
end
