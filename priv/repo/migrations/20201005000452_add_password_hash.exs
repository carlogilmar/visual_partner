defmodule Star.Repo.Migrations.AddPasswordHash do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :recover_hash, :string
    end
  end
end
