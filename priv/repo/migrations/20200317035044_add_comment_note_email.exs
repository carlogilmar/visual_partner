defmodule Star.Repo.Migrations.AddCommentNoteEmail do
  use Ecto.Migration

  def change do
    alter table(:comment_notes) do
      add :email, :string
    end

  end
end
