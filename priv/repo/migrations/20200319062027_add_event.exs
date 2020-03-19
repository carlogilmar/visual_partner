defmodule Star.Repo.Migrations.AddEvent do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :serial, primary_key: true
      add :title, :string
      add :description, :string
      add :date_desc, :string
      add :city, :string
      add :gallery_url, :string
      add :url, :string
      add :status, :boolean
      timestamps()
    end
  end
end
