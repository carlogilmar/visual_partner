defmodule StarWeb.LoginController do
  use StarWeb, :controller
  alias Star.Guardian
  alias Star.Session

  def index(conn, _params) do
    render(conn, "index.html")
  end

	def login(conn, params) do
    form_params = Map.has_key?(params, "_csrf_token")
    validate_params.({form_params, conn, params})
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/")
  end

  defp validate_params do
    fn
      {false, conn, _params} ->
        render(conn, "index.html", error: "", error_register: "")

      {true, conn, params} ->
        session = Session.auth_user(params["username"], params["password"])
        login_reply(session, conn)
    end
  end

  defp login_reply({:error, error}, conn) do
    conn |> render("index.html", error: error, error_register: "")
  end

  defp login_reply({:ok, user}, conn) do
    session = Guardian.encode_and_sign(user)
    redirect_session_by_role.({user.role, user.id, session, conn})
  end

  def redirect_session_by_role do
    fn
      {"ADMIN", _user_id, session, conn} ->
        Guardian.Plug.sign_in(conn, session) |> redirect(to: "/admin")
      {"USER", _user_id, session, conn} ->
        Guardian.Plug.sign_in(conn, session) |> redirect(to: "/user")
    end
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/")
  end

end
