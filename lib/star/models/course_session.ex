defmodule Star.CourseSession do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "course_sessions" do
    field :feedback, :string, default: "Feedback"
    field :session_date, :naive_datetime
    field :type, :string
    belongs_to :course, Star.Course
    has_many :agenda_item, Star.AgendaItem, on_delete: :delete_all
    has_many :promo_illustration, Star.PromoIllustration, on_delete: :delete_all
    has_many :enrollment, Star.Enrollment, on_delete: :delete_all
    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:feedback, :session_date, :type])
    |> validate_required([])
  end
end
