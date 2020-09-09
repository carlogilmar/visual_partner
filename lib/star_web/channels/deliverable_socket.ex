defmodule StarWeb.DeliverableChannel do
	use Phoenix.Channel
	alias Star.DeliverableOperator
	alias Star.IllustrationOperator

	def join("deliverable:join", %{}, socket) do
		deliverables = get_deliverables()
		{:ok, %{deliverables: deliverables}, socket}
	end

	def handle_in("deliverable:new", %{}, socket) do
	  DeliverableOperator.create("New Deliverable")
    {:reply, {:ok, %{deliverables: get_deliverables()}}, socket}
	end

	def handle_in("deliverable:show", %{"id" => id}, socket) do
		{deliverable, illustrations} = get_deliverable(id)
		{:reply, {:ok, %{deliverable: deliverable, illustrations: illustrations}}, socket}
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

	def handle_in("deliverable:new_illustration", %{"id" => id, "title" => title}, socket) do
		IllustrationOperator.create(id, title)
		{_deliverable, illustrations} = get_deliverable(id)
    {:reply, {:ok, %{illustrations: illustrations}}, socket}
	end

	defp get_deliverables do
		deliverables = DeliverableOperator.get_all()
		for deliverable <- deliverables do
			%{
				"id" => deliverable.id,
				"title" => deliverable.title,
				"status" => deliverable.status,
				"draft" => deliverable.draft
			}
		end
	end

	defp get_deliverable(id) do
		deliverable = DeliverableOperator.get_by_id(id)

		illustrations =
			for illustration <- deliverable.illustration do
				%{title: "Sin titulo", status: illustration.status, url: illustration.url, id: illustration.id}
			end

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
		{deliverable, illustrations}
	end

end
