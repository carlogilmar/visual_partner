defmodule Star.GalleryOperator do
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
    Repo.all(Gallery)
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

end
