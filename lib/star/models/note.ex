defmodule Star.Note do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "notes" do
    field :body, :string
    field :title, :string
    timestamps()
  end

  def changeset(model, attrs) do
    model
    |> cast(attrs, [:title, :body])
    |> validate_required([])
  end

end
