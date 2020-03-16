defmodule Star.Gallery do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "galleries" do
    field :title, :string
    field :cover, :string
    field :esp_desc, :string
    field :eng_desc, :string
    field :status, :boolean, default: false
    field :type, :string, default: "EVENT"
    timestamps()
    has_many :image, Star.Image, on_delete: :delete_all
  end

  def changeset(model, attrs) do
    model
    |> cast(attrs, [:title, :cover, :esp_desc, :eng_desc, :status, :type])
    |> validate_required([])
    |> validate_inclusion(:type, ["EVENT", "COMMUNITY", "MEETINGS", "RESOURCES", "PARTNERSHIP", "FUNNY"])

  end
end
