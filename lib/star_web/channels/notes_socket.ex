defmodule StarWeb.NotesChannel do
  use Phoenix.Channel
  alias Star.NoteOperator

  def join("notes:join", _msg, socket) do
    {:ok, %{notes: get_notes()}, socket}
  end

  def handle_in(
        "notes:show",
        %{"note" => note},
        socket
      ) do
    note = NoteOperator.get_by_id(note)

    note = %{
      id: note.id,
      title: note.title,
      date_desc: note.date_desc,
      body: note.body,
      status: note.status
    }

    {:reply, {:ok, %{note: note}}, socket}
  end

  def handle_in(
        "notes:update",
        %{"attr" => attr, "id" => id, "value" => value},
        socket
      ) do
    attrs = Map.new([{String.to_atom(attr), value}])
    {:ok, _model} = NoteOperator.update(id, attrs)
    {:reply, {:ok, %{notes: get_notes()}}, socket}
  end

  def handle_in(
        "notes:new",
        %{},
        socket
      ) do
    _ = NoteOperator.create("", "New Note")
    {:reply, {:ok, %{notes: get_notes()}}, socket}
  end

  def handle_in(
        "notes:delete",
        %{"id" => id},
        socket
      ) do
    _ = NoteOperator.delete(id)
    {:reply, {:ok, %{notes: get_notes()}}, socket}
  end

  defp get_notes do
    notes = NoteOperator.get_all()

    for note <- notes do
      %{
        "id" => note.id,
        "title" => note.title,
        "status" => note.status,
        "date_desc" => note.date_desc
      }
    end
  end
end
