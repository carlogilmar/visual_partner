defmodule Scalathon.User do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "users" do
    field :name, :string
    field :role, :string
    field :email, :string
    field :password, :string
    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:name, :role, :email, :password])
    |> validate_required([])
  end
end
