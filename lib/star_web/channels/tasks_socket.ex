defmodule StarWeb.TasksChannel do
	use Phoenix.Channel
	alias Star.TaskOperator

	def join("tasks:join", _msg, socket) do
		tasks = get_tasks()
    tasks_by_status = get_tasks_by_status(tasks)
		{:ok, %{tasks: tasks, todo: tasks_by_status["TO DO"], doing: tasks_by_status["DOING"], done: tasks_by_status["DONE"]}, socket}
	end

  def handle_in(
        "tasks:move_task",
        %{"id" => id, "value" => value},
        socket
      ) do

    case value do
      "TO DO" -> TaskOperator.update(id, :to_do)
      "DOING" -> TaskOperator.update(id, :doing)
      "DONE" -> TaskOperator.update(id, :done)
    end

		tasks = get_tasks()
    tasks_by_status = get_tasks_by_status(tasks)

		{:reply,
    {:ok, %{tasks: tasks, todo: tasks_by_status["TO DO"], doing: tasks_by_status["DOING"], done: tasks_by_status["DONE"]}},
    socket}
  end

  def get_tasks_by_status(tasks) do
    Enum.reduce(tasks,
      %{"TO DO" => [], "DOING" => [], "DONE" => []},
      fn task, acc ->
        %{acc| "#{task.status}" => acc[task.status] ++ [task] }
      end)
  end

	def get_tasks do
		tasks = TaskOperator.get_monthly_tasks()
		parse_tasks(tasks)
	end

	def parse_tasks(tasks) do
		for task <- tasks do
			%{
				id: task.id,
				title: task.title,
				status: task.status,
				description: task.description,
				year: task.inserted_at.year,
				month: task.inserted_at.month,
				day: task.inserted_at.day
			}
		end
	end
end
