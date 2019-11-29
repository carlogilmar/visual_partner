defmodule Star.Viewer do
  @moduledoc """
    Viewer model definition
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "viewers" do
    field :city, :string
    field :continent, :string
    field :country, :string
    field :region, :string
    field :time_zone, :string
    field :latitude, :float
    field :longitude, :float
    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [])
    |> validate_required([])
  end
end
