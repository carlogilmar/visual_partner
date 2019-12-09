defmodule StarWeb.GalleryChannel do
  use Phoenix.Channel
  alias Star.GalleryOperator

  def join("gallery:join", %{"gallery" => gallery_id}, socket) do
    {:ok, get_gallery(gallery_id), socket}
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
