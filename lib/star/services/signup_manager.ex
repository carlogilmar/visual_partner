defmodule Star.SignupManager do
  alias Star.EmailerSenderOperator
  alias Star.UserOperator
  @user_role "USER"

  def create_user(params) do
    params
    |> find_as_suscriptor()
    |> create_or_update_to_user()
    |> send_email_for_active()
  end

  def invite_user(email) do
    %{"email" => email}
    |> find_as_suscriptor()
    |> create_or_update_to_user()
    |> send_email_for_invite()
  end

  def find_as_suscriptor(params) do
    user = UserOperator.get_by_email(params["email"])

    case user do
      nil -> {params, :to_create}
      _user -> {user, :to_update}
    end
  end

  def create_or_update_to_user({params, :to_create}) do
    {:ok, user} = UserOperator.create_user(params["email"], "", "", @user_role)
    user
  end

  def create_or_update_to_user({user, :to_update}) do
    {:ok, user} = UserOperator.update(user.id, %{role: "USER"})
    user
  end

  def send_email_for_active(user) do
    case user.status do
      "INACTIVE" ->
        base_path = Application.get_env(:star, StarWeb.Endpoint)[:base_url]
        url = "#{base_path}register/#{user.identifier}"
        _ = EmailerSenderOperator.send_signup_email(user.email, url)
        user

      "ACTIVE" ->
        user
    end
  end

  def send_email_for_invite(user) do
    base_path = Application.get_env(:star, StarWeb.Endpoint)[:base_url]
    url = "#{base_path}register/#{user.identifier}"
    _ = EmailerSenderOperator.send_invite_email(user.email, url)
    user
  end

  def recover_password(email) do
    email
    |> UserOperator.get_by_email()
    |> validate_recovery_user()
    |> send_recovery_email()
  end

  defp validate_recovery_user(nil) do
    {:error, nil}
  end

  defp validate_recovery_user(user) do
    case {user.role, user.status} do
      {"USER", "ACTIVE"} ->
        {:ok, user}

      {"USER", "INACTIVE"} ->
        {:error, user}
    end
  end

  defp send_recovery_email({:ok, user}) do
    recover_hash = Ecto.UUID.generate()
    base_path = Application.get_env(:star, StarWeb.Endpoint)[:base_url]
    url = "#{base_path}recover/#{recover_hash}"
    _ = EmailerSenderOperator.send_recover_password(user.email, url)
    {:ok, user} = UserOperator.update(user.id, %{recover_hash: recover_hash})
    {:ok, user}
  end

  defp send_recovery_email({:error, user}) do
    {:error, user}
  end
end
