defmodule Star.RequestManager do
  def post(url, params, content_type) do
    case HTTPoison.post(url, Poison.encode!(params), content_type) do
      {:ok, response} ->
        case response.status_code do
          200 -> decode_response.(response.body)
          status when status in 400..499 -> :client_error
          status when status in 500..599 -> :server_error
        end

      _error ->
        :unknown_error
    end
  end

  defp decode_response do
    fn response ->
      {:ok, body} = Poison.decode(response)
      body
    end
  end
end
