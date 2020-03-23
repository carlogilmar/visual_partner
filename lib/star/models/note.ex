defmodule Star.Note do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "notes" do
    field :body, :string
    field :title, :string
    field :status, :boolean, default: false
    field :author, :string, default: "@carlogilmar"
    field :date_desc, :string
    timestamps()
    has_many :comment_note, Star.CommentNote, on_delete: :delete_all
  end

  def changeset(model, attrs) do
    model
    |> cast(attrs, [:title, :body, :status, :author, :date_desc])
    |> validate_required([])
  end
end
