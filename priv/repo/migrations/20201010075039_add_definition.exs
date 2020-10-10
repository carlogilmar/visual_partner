defmodule Star.Repo.Migrations.AddDefinition do
  use Ecto.Migration

  def change do
    create table(:definitions, primary_key: false) do
      add :id, :serial, primary_key: true
      add :description, :string
      add :user_id, references(:users, on_delete: :delete_all)
      timestamps()
    end
  end
end
