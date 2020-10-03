defmodule Star.Repo.Migrations.AddCourses do
  use Ecto.Migration

  def change do
    create table(:courses, primary_key: false) do
      add :id, :serial, primary_key: true
      add :title, :string
      add :cover_url, :string
      add :slides_url, :string
      add :workbook_url, :string
      add :visual_guide_url, :string
      add :language, :string
      add :duration, :string
      add :hours, :integer
      add :description, :text
      add :requirements, :text
      add :goals, :text
      add :references, :text
      add :payment, :text
      timestamps()
    end

    create table(:course_sessions, primary_key: false) do
      add :id, :serial, primary_key: true
      add :feedback, :string
      add :status, :string
      add :session_date, :naive_datetime
      add :type, :string
      add :description, :text
      add :course_id, references(:courses, on_delete: :delete_all)
      timestamps()
    end

    create table(:agenda_items, primary_key: false) do
      add :id, :serial, primary_key: true
      add :title, :string
      add :status, :boolean
      add :course_session_id, references(:course_sessions, on_delete: :delete_all)
      timestamps()
    end

    create table(:promo_illustrations, primary_key: false) do
      add :id, :serial, primary_key: true
      add :title, :string
      add :url, :string
      add :course_session_id, references(:course_sessions, on_delete: :delete_all)
      timestamps()
    end

    create table(:enrollments, primary_key: false) do
      add :id, :serial, primary_key: true
      # Expectations
      add :location, :string
      add :expectations, :text
      add :occupation, :string
      add :detonator, :string
      # Feedback
      add :finished, :string
      add :rate, :integer
      add :favourites, :text
      add :worst, :text
      add :instructor_feedback, :text
      add :comments, :text
      # relationships
      add :course_session_id, references(:course_sessions, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)
      add :status, :string
      timestamps()
    end
  end
end
