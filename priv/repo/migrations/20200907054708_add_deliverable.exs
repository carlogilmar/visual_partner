defmodule Star.Repo.Migrations.AddDeliverable do
  use Ecto.Migration

  def change do
    create table(:deliverables, primary_key: false) do
      add :id, :serial, primary_key: true
      add :title, :string
      add :status, :string
      add :draft, :boolean
      add :price, :integer
      add :hours, :integer
      add :description, :string
      add :url, :string
      add :comments, :string
      timestamps()
    end

    create table(:illustrations, primary_key: false) do
      add :id, :serial, primary_key: true
      add :url, :string
      add :status, :string
      add :deliverable_id, references(:deliverables, on_delete: :delete_all)
      timestamps()
    end

  end
end
