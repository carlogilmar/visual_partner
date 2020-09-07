defmodule Star.Illustration do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "illustrations" do
    field :url, :string
    field :status, :string, default: "TO DO"
    timestamps()
    belongs_to :deliverable, Star.Deliverable
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:url, :status])
    |> validate_required([])
  end
end