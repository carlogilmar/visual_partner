defmodule Star.Sponsorship do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "sponsorships" do
    field :author, :string
    field :desc, :string
    field :status, :string
    timestamps()
  end

  def changeset(model, attrs) do
    model
    |> cast(attrs, [:status])
    |> validate_required([])
  end

end
