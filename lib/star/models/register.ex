defmodule Star.Register do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "registers" do
    field :email, :string
    field :status, :string
    field :user_status, :string
    belongs_to :course_session, Star.CourseSession
    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:email, :status, :user_status])
    |> validate_required([])
  end
end
