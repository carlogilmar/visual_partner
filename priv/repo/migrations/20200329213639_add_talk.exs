defmodule Star.Repo.Migrations.AddTalk do
  use Ecto.Migration

  def change do
    create table(:talks, primary_key: false) do
      add :id, :serial, primary_key: true
      add :title, :string
      add :url, :string
      add :cover, :string
      add :clicks, :integer
      add :draft, :boolean
      timestamps()
    end
  end
end
