defmodule StarWeb.SignupController do
  use StarWeb, :controller
  alias Star.UserOperator
  alias Star.EmailerSenderOperator
  @suscriptor_role "SUSCRIPTOR"

  def index(conn, _params) do
    render(conn, "index.html", msg: "")
  end

  def create_user(conn, params) do
    user = Star.SignupManager.create_user(params)

    case user.status do
      "INACTIVE" ->
        render(conn, "success.html", user: user)

      "ACTIVE" ->
        render(conn, "index.html", msg: "El email ya esta registrado.")
    end
  end

  def recover(conn, params) do
    Star.SignupManager.recover_password(params["email"])
    render(conn, "index.html", msg: "")
  end

  def suscribe(conn, params) do
    {status, user} = UserOperator.create_user(params["email"], "", "", @suscriptor_role)

    case status do
      :ok -> EmailerSenderOperator.send_suscribe_email(user.email)
      _ -> :nothing_to_do
    end

    render(conn, "suscriptor.html", user: user)
  end
end
