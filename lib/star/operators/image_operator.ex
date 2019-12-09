defmodule Star.ImageOperator do
  alias Star.Image
  alias Star.Repo
  alias Star.GalleryOperator

  def create(gallery_id, url, eng_desc, esp_desc) do
    gallery = GalleryOperator.get_by_id(gallery_id)

    %Image{
      gallery: gallery,
      url: url,
      eng_desc: eng_desc,
      esp_desc: esp_desc}
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Image, id)
  end

  def get_all do
    Repo.all(Image)
  end

  def delete(id) do
    gallery = get_by_id(id)
    Repo.delete(gallery)
  end

  def update(id, attrs) do
    img = get_by_id(id)

    img
    |> Image.changeset(attrs)
    |> Repo.update()
  end

end
