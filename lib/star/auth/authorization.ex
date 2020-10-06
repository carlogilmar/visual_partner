defmodule Star.Auth.AuthorizationPlug do
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2]

  def init(_params) do
  end

  def call(conn, _params) do
    user = conn.private[:guardian_default_resource]

    case user.role do
      "ADMIN" ->
        conn

      "USER" ->
        redirect(conn, to: "/dashboard")
    end
  end
end
