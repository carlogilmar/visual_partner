defmodule Star.Repo.Migrations.AddNoteStatus do
  use Ecto.Migration

  def change do
    alter table(:notes) do
      add :status, :boolean
    end
  end
end
