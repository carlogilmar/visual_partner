defmodule Star.SponsorshipOperator do
  import Ecto.Query, only: [from: 2]
  alias Star.Sponsorship
  alias Star.Repo

  def create(author, desc) do
    %Sponsorship{
      author: author,
      status: "TO_REVIEW",
      desc: desc}
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Sponsorship, id)
  end

  def get_all do
    query =
      from(s in Sponsorship,
        order_by: [desc: s.inserted_at]
      )

    query
    |> Repo.all()
  end

  def delete(id) do
    sponsorship = get_by_id(id)
    Repo.delete(sponsorship)
  end

end
