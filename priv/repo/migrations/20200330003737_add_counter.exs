defmodule Star.Repo.Migrations.AddCounter do
  use Ecto.Migration

  def change do
    alter table(:galleries) do
      add :counter, :integer
    end
  end
end
