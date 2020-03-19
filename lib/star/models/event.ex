defmodule Star.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "events" do
    field :title, :string
    field :city, :string
    field :url, :string
    field :description, :string
    field :date_desc, :string
    field :gallery_url, :string
    field :status, :boolean, default: true
    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:title, :city, :url, :status, :description, :date_desc, :gallery_url])
    |> validate_required([])
  end
end
