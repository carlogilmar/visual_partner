defmodule Star.Guardian.ErrorHandler do
  @moduledoc false
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2]

  def auth_error(conn, {_type, _reason}, _opts) do
    redirect(conn, to: "/welcome")
  end
end
