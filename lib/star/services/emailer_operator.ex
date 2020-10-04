defmodule Star.EmailerOperator do
  alias Star.Emailer
  alias Star.EmailManager
  alias Star.Repo

  def add_emailer(content, title) do
    %Emailer{}
    |> Emailer.changeset(%{content: content, title: title})
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Emailer, id)
  end

  def update(id, attrs) do
    emailer = get_by_id(id)

    emailer
    |> Emailer.changeset(attrs)
    |> Repo.update()
  end

  def delete(id) do
    emailer = get_by_id(id)
    Repo.delete(emailer)
  end

  def get_all do
    Repo.all(Emailer)
  end

  def send_preview(id, email) do
    emailer = get_by_id(id)
    _ = EmailManager.send_email(emailer, email)
  end
end

defmodule Star.EmailerBroadcastOperator do
  alias Star.UserOperator
  alias Star.EmailerOperator

  def send_email(emailer_id) do
    users = UserOperator.get_all_by_role("USER")
    suscriptors = UserOperator.get_all_by_role("SUSCRIPTOR")
    users_for_send = users ++ suscriptors

    Enum.each(
      users_for_send,
      fn user ->
        _ = EmailerOperator.send_preview(emailer_id, user.email)
      end
    )
  end
end

defmodule Star.EmailerSenderOperator do
  alias Star.EmailManager

  def get_template(template_src) do
    template = File.stream!(Path.join(:code.priv_dir(:star), template_src))

    template.path
    |> File.read()
  end

  def send_sponsor_email(email) do
    {:ok, content} = get_template("emails/sponsor.txt")
    title = " The Apprentice's Journey :: Sponsorship Request"
    _ = EmailManager.send_email(%{title: title, content: content}, email)
  end

  def send_signup_email(email, url) do
    {:ok, content} = get_template("emails/singup.txt")
    content = EEx.eval_string(content, url: url)
    title = " Visual Partnership :: Completa tu registro"

    _ = EmailManager.send_email(%{title: title, content: content}, email)
  end

  def send_invite_email(email, url) do
    {:ok, content} = get_template("emails/invite.txt")
    content = EEx.eval_string(content, url: url)
    title = "Join to The Apprentice's Journey :: Invite "

    _ = EmailManager.send_email(%{title: title, content: content}, email)
  end

  def send_welcome_email(email) do
    {:ok, content} = get_template("emails/welcome.txt")
    title = " The Apprentice's Journey :: Welcome"
    _ = EmailManager.send_email(%{title: title, content: content}, email)
  end

  def send_suscribe_email(email) do
    {:ok, content} = get_template("emails/suscribe.txt")
    title = " Visual Partnership :: Thanks for suscribe! "
    _ = EmailManager.send_email(%{title: title, content: content}, email)
  end
end
