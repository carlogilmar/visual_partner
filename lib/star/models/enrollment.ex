defmodule Star.Enrollment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "enrollments" do
    field :status, :string, default: "ENROLL"
    # Expectations
    field :location, :string
    field :expectations, :string
    field :occupation, :string
    field :detonator, :string
    # Feedback
    field :finished, :string
    field :rate, :integer
    field :favourites, :string
    field :worst, :string
    field :instructor_feedback, :string
    field :comments, :string
    belongs_to :course_session, Star.CourseSession
    belongs_to :user, Star.User
    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [
      :status,
      :location,
      :expectations,
      :occupation,
      :detonator,
      :finished,
      :rate,
      :favourites,
      :worst,
      :instructor_feedback,
      :comments
    ])
    |> validate_required([])
  end
end
