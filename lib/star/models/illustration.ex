defmodule Star.Illustration do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "illustrations" do
    field :url, :string
    field :status, :string
    timestamps()
    belongs_to :deliverable, Star.Deliverable
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:url, :status])
    |> validate_required([])
  end
end
