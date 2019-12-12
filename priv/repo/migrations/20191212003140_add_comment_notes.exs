defmodule Star.Repo.Migrations.AddCommentNotes do
  use Ecto.Migration

  def change do
    create table(:comment_notes, primary_key: false) do
      add :id, :serial, primary_key: true
      add :author, :string
      add :description, :text
      timestamps()
      add :note_id, references(:notes, on_delete: :delete_all)
    end
  end
end
