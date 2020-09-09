defmodule StarWeb.DeliverableChannel do
	use Phoenix.Channel
	alias Star.DeliverableOperator

	def join("deliverable:join", %{}, socket) do
		deliverables = get_deliverables()
		{:ok, %{deliverables: deliverables}, socket}
	end

	def handle_in("deliverable:show", %{"id" => id}, socket) do
		deliverable = DeliverableOperator.get_by_id(id)

		deliverable = %{
			comments: deliverable.comments,
			description: deliverable.description,
			draft: deliverable.draft,
			hours: deliverable.hours,
			id: deliverable.id,
			price: deliverable.price,
			status: deliverable.status,
			title: deliverable.title,
			url: deliverable.url
		}

		{:reply, {:ok, %{deliverable: deliverable}}, socket}
	end

	def handle_in("deliverable:delete", %{"id" => id}, socket) do
	  DeliverableOperator.delete(id)
    {:reply, {:ok, %{deliverables: get_deliverables()}}, socket}
	end

  def handle_in("deliverable:update", %{"attr" => attr, "id" => id, "value" => value}, socket) do
    attrs = Map.new([{String.to_atom(attr), value}])
    {:ok, _model} = DeliverableOperator.update(id, attrs)
    {:reply, {:ok, %{deliverables: get_deliverables()}}, socket}
  end

	defp get_deliverables do
		deliverables = DeliverableOperator.get_all()
		for deliverable <- deliverables do
			%{
				"id" => deliverable.id,
				"title" => deliverable.title,
				"status" => deliverable.status
			}
		end
	end

end
