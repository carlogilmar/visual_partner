defmodule Star.Talk do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "talks" do
    field :title, :string
    field :url, :string
    field :cover, :string
    field :clicks, :integer, default: 0
    field :draft, :boolean, default: false
    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:title, :url, :cover, :clicks, :draft])
    |> validate_required([])
  end
end
