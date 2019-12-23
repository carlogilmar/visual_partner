defmodule Star.Repo.Migrations.AddModel do
  use Ecto.Migration

  def change do
    create table(:models, primary_key: false) do
      add :id, :serial, primary_key: true
      add :url, :string
      add :title, :string
      add :esp_desc, :text
      add :eng_desc, :text
      timestamps()
    end
  end
end
