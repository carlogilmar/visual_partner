defmodule StarWeb.NoteChannel do
  use Phoenix.Channel
  alias Star.NoteOperator

  def join("note:join", %{"note" => id}, socket) do
    {:ok, %{note: get_note(id)}, socket}
  end

  def get_note(id) do
    id = String.to_integer(id)
    note = NoteOperator.get_by_id(id)
    %{"title" => note.title, "body" => note.body}
  end

end
