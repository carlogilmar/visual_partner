defmodule StarWeb.AdminController do
  use StarWeb, :controller
  alias Star.UserOperator

  def index(conn, _params) do
    user = conn.private.guardian_default_claims["sub"] |> UserOperator.get_by_id()
    validate_role.({user.role, conn})
  end

  def validate_role do
    fn
      {"ADMIN", conn} -> render(conn, "index.html")
      {"USER", conn} -> redirect(conn, to: "/logout")
    end
  end
end
