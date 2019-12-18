defmodule Star.Repo.Migrations.AddSponsors do
  use Ecto.Migration

  def change do
    create table(:sponsorships, primary_key: false) do
      add :id, :serial, primary_key: true
      add :author, :string
      add :desc, :string
      add :status, :string
      timestamps()
    end
  end
end
