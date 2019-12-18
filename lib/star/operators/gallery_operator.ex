defmodule Star.GalleryOperator do
  import Ecto.Query, only: [from: 2]
  alias Star.Gallery
  alias Star.Repo

  def create(title, cover, eng_desc, esp_desc) do
    %Gallery{}
    |> Gallery.changeset(%{title: title, cover: cover, eng_desc: eng_desc, esp_desc: esp_desc})
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Gallery, id) |> Repo.preload([:image])
  end

  def get_all do
    query =
      from(g in Gallery,
        order_by: [desc: g.inserted_at]
      )

    query
    |> Repo.all()
  end

  def delete(id) do
    gallery = get_by_id(id)
    Repo.delete(gallery)
  end

  def update_gallery(id, attrs) do
    gallery = get_by_id(id)

    gallery
    |> Gallery.changeset(attrs)
    |> Repo.update()
  end

  def find_by_status(status) do
    query =
      from(g in Gallery,
        where: g.status == ^status,
        order_by: [desc: g.inserted_at]
      )

    query
    |> Repo.all()
  end
end
