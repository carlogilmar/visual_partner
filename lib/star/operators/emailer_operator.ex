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
