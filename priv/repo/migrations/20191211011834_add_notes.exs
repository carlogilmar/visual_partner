defmodule Star.Repo.Migrations.AddNotes do
  use Ecto.Migration

  def change do
    create table(:notes, primary_key: false) do
      add :id, :serial, primary_key: true
      add :body, :text
			timestamps()
    end
  end
end
