defmodule Star.PromoIllustration do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "promo_illustrations" do
    field :title, :string
    field :url, :string
    timestamps()
    belongs_to :course_session, Star.CourseSession
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:title, :url])
    |> validate_required([])
  end
end
