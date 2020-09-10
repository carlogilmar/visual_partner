defmodule Star.PromoIllustrationOperator do
  alias Star.CourseSessionOperator
  alias Star.PromoIllustration
  alias Star.Repo

  def create(course_session_id, title) do
    course_session = CourseSessionOperator.get_by_id(course_session_id)

    %PromoIllustration{
      title: title,
      course_session: course_session
    }
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(PromoIllustration, id)
  end

  def get_all do
    Repo.all(PromoIllustration)
  end

  def delete(id) do
    model = get_by_id(id)
    Repo.delete(model)
  end

  def update(id, attrs) do
    model = get_by_id(id)

    model
    |> PromoIllustration.changeset(attrs)
    |> Repo.update()
  end
end
