defmodule Star.CourseSession do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "course_sessions" do
    field :feedback, :string
    field :session_date, :naive_datetime
    field :type, :string
    belongs_to :course, Star.Course
    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [])
    |> validate_required([])
  end
end
