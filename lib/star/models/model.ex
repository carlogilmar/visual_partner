defmodule Star.Model do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "models" do
    field :url, :string
    field :title, :string
    field :esp_desc, :string
    field :eng_desc, :string
    field :draft, :boolean, default: false
    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [])
    |> validate_required([])
  end
end
