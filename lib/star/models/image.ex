defmodule Star.Image do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "images" do
    field :url, :string
    field :esp_desc, :string
    field :eng_desc, :string
    timestamps()
    belongs_to :gallery, Star.Gallery
  end

  def changeset(model, attrs) do
    model
    |> cast(attrs, [:gallery, :url, :esp_desc, :eng_desc])
    |> validate_required([])
  end

end
