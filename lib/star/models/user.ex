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
    field :identifier, :string
    field :recover_hash, :string
    field :status, :string, default: "INACTIVE"
    field :description, :string
    field :city, :string
    field :country, :string
    timestamps()
    has_many :enrollment, Star.Enrollment, on_delete: :delete_all
    has_many :definition, Star.Definition, on_delete: :delete_all
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [
      :identifier,
      :name,
      :role,
      :email,
      :password,
      :status,
      :recover_hash,
      :description,
      :city,
      :country
    ])
    |> validate_required([])
  end
end
