defmodule StarWeb.NoteChannel do
  use Phoenix.Channel
  alias Star.NoteOperator
  alias Star.CommentNoteOperator

  def join("note:join", %{"note" => id}, socket) do
    {:ok, get_note(id), socket}
  end

  def handle_in(
    "note:new_comment",
    %{"id" => id, "username" => username, "comment" => comment},
    socket
  ) do
    _ = CommentNoteOperator.create(id, username, comment)
    {:reply, {:ok, get_note(id)}, socket}
  end

  def get_note(id) do
    id = String.to_integer(id)
    note = NoteOperator.get_by_id(id)

    comments =
      for comment <- note.comment_note do
        %{
          "author" => comment.author,
          "description" => comment.description
        }
      end

    note = %{"title" => note.title, "body" => note.body}

    %{note: note, comments: comments}
  end

end
