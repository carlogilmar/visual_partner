defmodule Star.Repo.Migrations.AddDescription do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :description, :string
      add :city, :string
      add :country, :string
    end
  end
end
