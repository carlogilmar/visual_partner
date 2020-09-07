defmodule Star.Deliverable do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "deliverables" do
    field :title, :string
    field :status, :string, default: "TO_START"
    field :draft, :boolean, default: false
    field :price, :integer, default: 0
    field :hours, :integer, default: 0
    field :description, :string, default: "..."
    field :url, :string, default: "http://"
    field :comments, :string, default: "..."
    timestamps()
    has_many :illustration, Star.Illustration, on_delete: :delete_all
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:title, :status, :draft, :price, :hours, :description, :url, :comments])
    |> validate_required([])
  end
end
