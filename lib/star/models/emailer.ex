defmodule Star.Emailer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "emailers" do
    field :title, :string
    field :content, :string
    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:title, :content])
    |> validate_required([])
  end
end
