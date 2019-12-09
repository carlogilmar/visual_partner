defmodule Star.Gallery do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "galleries" do
    field :title, :string
    field :cover, :string
    field :description, :string
    field :status, :boolean, default: false
    timestamps()
    has_many :image, Star.Image, on_delete: :delete_all
  end

  def changeset(model, attrs) do
    model
    |> cast(attrs, [:title, :description, :status])
    |> validate_required([])
  end

end
