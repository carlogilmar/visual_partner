defmodule Star.User do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "users" do
    field :role, :string
    field :email, :string
    field :name, :string
    field :password, :string
    field :identifier,:string
    field :status, :string, default: "INACTIVE"
    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:identifier, :name, :role, :email, :password, :status])
    |> validate_required([])
  end
end
