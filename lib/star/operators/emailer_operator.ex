defmodule Star.EmailerOperator do
  alias Star.Emailer
  alias Star.Repo

  def add_emailer(content) do
    %Emailer{}
    |> Emailer.changeset(%{content: content})
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Emailer, id)
  end

  def update(id, content) do
    emailer = get_by_id(id)

    emailer
    |> Emailer.changeset(%{content: content})
    |> Repo.update()
  end

  def delete(id) do
    emailer = get_by_id(id)
    Repo.delete(emailer)
  end

  def get_all do
    Repo.all(Emailer)
  end

end
