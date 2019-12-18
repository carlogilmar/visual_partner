defmodule Star.CommentNoteOperator do
  import Ecto.Query, only: [from: 2]
  alias Star.CommentNote
  alias Star.Repo
  alias Star.NoteOperator

  def create(note_id, author, description) do
    note = NoteOperator.get_by_id(note_id)

    %CommentNote{
      note: note,
      author: author,
      description: description
    }
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(CommentNote, id)
  end

  def get_all do
    query =
      from(g in CommentNote,
        order_by: [desc: g.inserted_at]
      )

    query
    |> Repo.all()
    |> Repo.preload([:note])
  end

  def delete(id) do
    model = get_by_id(id)
    Repo.delete(model)
  end

  def update(id, attrs) do
    model = get_by_id(id)

    model
    |> CommentNote.changeset(attrs)
    |> Repo.update()
  end
end
