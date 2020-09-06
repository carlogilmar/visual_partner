defmodule Star.Repo.Migrations.AddTask do
  use Ecto.Migration

  def change do
    create table(:tasks, primary_key: false) do
      add :id, :serial, primary_key: true
      add :title, :string
      add :description, :string
      add :status, :string
      add :pinned, :boolean
      timestamps()
    end
  end
end
