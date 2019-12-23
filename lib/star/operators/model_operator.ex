defmodule Star.ModelOperator do
  alias Star.Model
  alias Star.Repo

  def create(title, url, esp_desc, eng_desc) do
     %Model{
       title: title,
       url: url,
       esp_desc: esp_desc,
       eng_desc: eng_desc
      }
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Model, id)
  end

  def get_all do
    Repo.all(Model)
  end

  def delete(id) do
    model = get_by_id(id)
    Repo.delete(model)
  end

  def update(id, attrs) do
    model = get_by_id(id)

    model
    |> Model.changeset(attrs)
    |> Repo.update()
  end

end
