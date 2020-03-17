defmodule Star.Note do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "notes" do
    field :body, :string
    field :title, :string
    field :status, :boolean, default: false
    timestamps()
    has_many :comment_note, Star.CommentNote, on_delete: :delete_all
  end

  def changeset(model, attrs) do
    model
    |> cast(attrs, [:title, :body, :status])
    |> validate_required([])
  end
end
