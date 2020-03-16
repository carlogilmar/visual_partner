defmodule Star.Repo.Migrations.AddGalleryType do
  use Ecto.Migration

  def change do
    alter table(:galleries) do
      add :type, :string
    end
  end
end
