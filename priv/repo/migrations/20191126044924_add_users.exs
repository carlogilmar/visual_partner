defmodule Star.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :serial, primary_key: true
      add :name, :string
      add :role, :string
      add :email, :string
      add :password, :string
      add :status, :string
      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
