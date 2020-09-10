defmodule Star.Repo.Migrations.AddCourses do
  use Ecto.Migration

  def change do
    create table(:courses, primary_key: false) do
      add :id, :serial, primary_key: true
      add :title, :string
      add :slides_url, :string
      add :workbook_url, :string
      add :visual_guide_url, :string
      add :description, :string
      add :language, :string
      add :duration, :string
      add :requirements, :string
      add :goals, :string
      add :references, :string
      add :payment, :string
      add :hours, :integer
      timestamps()
    end
  end
end
