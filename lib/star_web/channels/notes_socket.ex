defmodule StarWeb.NotesChannel do
  use Phoenix.Channel
  alias Star.AnalyticsUtil
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
		note = %{id: note.id, title: note.title, body: note.body}
    {:reply, {:ok, %{note: note}}, socket}
  end

  defp get_notes do
    notes = NoteOperator.get_all()
    for note <- notes do
      %{
        "id" => note.id,
        "title" => note.title
      }
    end
  end

end
