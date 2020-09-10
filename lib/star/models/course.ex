defmodule Star.Course do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "courses" do
    field :title, :string
    field :slides_url, :string
    field :workbook_url, :string
    field :visual_guide_url, :string
    field :description, :string
    field :language, :string
    field :duration, :string
    field :requirements, :string
    field :goals, :string
    field :references, :string
    field :payment, :string
    field :hours, :integer
    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:title, :slides_url, :workbook_url, :visual_guide_url, :description, :language, :duration, :requirements, :goals, :references, :payment, :hours])
    |> validate_required([])
  end
end
