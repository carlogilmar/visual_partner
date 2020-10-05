defmodule Star.Auth.AuthorizationPlug do
  import Plug.Conn

  def init(_params) do
  end

  def call(conn, _params) do
    user = conn.private[:guardian_default_resource]

    case user.role do
      "ADMIN" ->
        conn

      "USER" ->
        send_resp(conn, 401, "Ops! No hay nada para ti aquí...")
    end
  end
end
