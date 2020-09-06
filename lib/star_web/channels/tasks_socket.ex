defmodule StarWeb.TasksChannel do
	use Phoenix.Channel
	alias Star.TaskOperator

	def join("tasks:join", _msg, socket) do
		tasks = get_tasks()
		{:ok, %{tasks: tasks}, socket}
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
