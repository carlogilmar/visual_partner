defmodule Star.Repo.Migrations.AddEmailers do
  use Ecto.Migration

  def change do
    create table(:emailers, primary_key: false) do
      add :id, :serial, primary_key: true
      add :title, :string
      add :content, :text
      timestamps()
    end
  end
end
