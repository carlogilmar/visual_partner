defmodule Star.Repo.Migrations.AddUuid do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :identifier, :string
    end
  end
end
