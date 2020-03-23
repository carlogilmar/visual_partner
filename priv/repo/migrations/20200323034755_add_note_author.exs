defmodule Star.Repo.Migrations.AddNoteAuthor do
  use Ecto.Migration

  def change do
    alter table(:notes) do
      add :author, :string
      add :date_desc, :string
    end
  end
end
