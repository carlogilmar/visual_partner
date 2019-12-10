defmodule StarWeb.GalleryChannel do
  use Phoenix.Channel
  alias Star.GalleryOperator
	alias Star.ImageOperator

  def join("gallery:join", %{"gallery" => gallery_id}, socket) do
    {:ok, get_gallery(gallery_id), socket}
  end

  def handle_in(
    "gallery:update",
    %{"attr" => attr, "id" => id, "value" => value},
    socket
  ) do
    attrs = Map.new([{String.to_atom(attr), value}])
    {:ok, _model} = GalleryOperator.update_gallery(id, attrs)
    {:reply, {:ok, %{status: "200"}}, socket}
  end

  def handle_in(
    "gallery:update_img",
    %{"attr" => attr, "id" => id, "value" => value},
    socket
  ) do
    attrs = Map.new([{String.to_atom(attr), value}])
    {:ok, _model} = ImageOperator.update(id, attrs)
    {:reply, {:ok, %{status: "200"}}, socket}
  end

  def handle_in(
    "gallery:delete_img",
    %{"id" => id, "gallery" => gallery},
    socket
  ) do
		_ = ImageOperator.delete(id)
    {:reply, {:ok, get_gallery(gallery)}, socket}
  end

  def handle_in(
    "gallery:new_img",
    %{"gallery" => gallery},
    socket
  ) do
		url = "https://res.cloudinary.com/carlogilmar/image/upload/v1575604431/apprentices_journey/carlogilmar_logo_uyofzd.png"
		_ = ImageOperator.create(gallery, url, "", "")
    {:reply, {:ok, get_gallery(gallery)}, socket}
  end

  defp get_gallery(gallery_id) do
    gallery_id
    |> String.to_integer()
    |> GalleryOperator.get_by_id()
    |> send_by_socket()
  end

  def send_by_socket(gallery) do
    gallery_for_send = %{
      "id" => gallery.id,
      "cover" => gallery.cover,
      "eng_desc" => gallery.eng_desc,
      "esp_desc" => gallery.esp_desc,
      "status" => gallery.status,
      "title" => gallery.title
    }

    images =
      for image <- gallery.image do
        %{
          "id" => image.id,
          "url" => image.url,
          "eng_desc" => image.eng_desc,
          "esp_desc" => image.esp_desc
        }
      end

    %{gallery: gallery_for_send, images: images}
  end

end
