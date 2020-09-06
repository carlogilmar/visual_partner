defmodule Star.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "tasks" do
    field :title, :string
    field :description, :string
    field :status, :string, default: "TO DO"
    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:title, :description, :status])
    |> validate_required([])
  end
end
