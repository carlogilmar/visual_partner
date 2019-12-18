defmodule Star.Repo.Migrations.AddViewer do
  use Ecto.Migration

  def change do
    create table(:viewers, primary_key: false) do
      add :id, :serial, primary_key: true
      add :city, :string
      add :continent, :string
      add :country, :string
      add :region, :string
      add :time_zone, :string
      add :latitude, :float
      add :longitude, :float
      timestamps()
    end
  end
end
