defmodule StarWeb.SignupController do
  use StarWeb, :controller
	alias Star.UserOperator
	@user_role "USER"

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create_user(conn, params) do
		{:ok, user} = UserOperator.create_user(params["email"], params["name"], params["password"], @user_role)
    render(conn, "success.html", user: user)
  end

end
