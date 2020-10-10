defmodule Star.Repo.Migrations.AddPreregister do
  use Ecto.Migration

  def change do
    create table(:registers, primary_key: false) do
      add :id, :serial, primary_key: true
      add :email, :string
      add :status, :string
      add :user_status, :string
      add :course_session_id, references(:course_sessions, on_delete: :delete_all)
      timestamps()
    end
  end
end
