defmodule Star.AgendaItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "agenda_items" do
    field :title, :string
    field :status, :boolean, default: false
    belongs_to :course_session, Star.CourseSession
    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:title, :status])
    |> validate_required([])
  end
end
