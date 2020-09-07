defmodule Star.TaskOperator do
  import Ecto.Query, only: [from: 2]
  alias Star.Task
  alias Star.Repo

  def create(title, description, date) do
    %Task{
      title: title,
      description: description,
      deadline: date
    }
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(Task, id)
  end

  def get_by_status(status) do
    query =
      from(n in Task,
        where: n.status == ^status,
        order_by: [desc: n.inserted_at]
      )

    Repo.all(query)
  end

  def get_all do
    query =
      from(n in Task,
        order_by: [desc: n.inserted_at]
      )

    Repo.all(query)
  end

  def get_all_by_dates(min_date, max_date) do
    query =
      from(n in Task,
        order_by: [desc: n.inserted_at],
        where:
          n.inserted_at <= ^max_date and
            n.inserted_at >= ^min_date
      )

    Repo.all(query)
  end

  def get_monthly_tasks do
    {min_date, max_date} = get_current_month_dates()
    get_all_by_dates(min_date, max_date)
  end

  defp get_current_month_dates do
    today = DateTime.utc_now()
    today_time = DateTime.to_time(today)
    today_date = DateTime.to_date(today)
    {:ok, max_date} = NaiveDateTime.new(today_date, today_time)

    {:ok, start_date} = Date.new(today.year, today.month, 01)
    {:ok, min_date} = NaiveDateTime.new(start_date, ~T[00:00:00])

    {min_date, max_date}
  end

  def delete(id) do
    model = get_by_id(id)
    Repo.delete(model)
  end

  def update(id, :to_do), do: update(id, %{status: "TO DO"})
  def update(id, :doing), do: update(id, %{status: "DOING"})
  def update(id, :done), do: update(id, %{status: "DONE"})

  def update(id, attrs) do
    model = get_by_id(id)

    model
    |> Task.changeset(attrs)
    |> Repo.update()
  end
end
