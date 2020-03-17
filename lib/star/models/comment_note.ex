defmodule Star.CommentNote do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "comment_notes" do
    field :author, :string
    field :email, :string
    field :description, :string
    timestamps()
    belongs_to :note, Star.Note
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [])
    |> validate_required([])
  end
end
