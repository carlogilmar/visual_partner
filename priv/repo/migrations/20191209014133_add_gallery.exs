defmodule Star.Repo.Migrations.AddGallery do
  use Ecto.Migration

  def change do
    create table(:galleries, primary_key: false) do
      add :id, :serial, primary_key: true
      add :title, :string
      add :cover, :string
      add :esp_desc, :string
      add :eng_desc, :string
      add :status, :boolean
      timestamps()
    end

    create table(:images, primary_key: false) do
      add :id, :serial, primary_key: true
      add :url, :string
      add :esp_desc, :string
      add :eng_desc, :string
      timestamps()
      add :gallery_id, references(:galleries, on_delete: :delete_all)
    end
  end
end
