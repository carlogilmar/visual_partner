defmodule Star.Guardian.ErrorHandler do
  @moduledoc false
  import Plug.Conn

  def auth_error(conn, {_type, _reason}, _opts) do
    send_resp(conn, 401, "Scalathon :: Usuario No Logueado ::")
  end
end
