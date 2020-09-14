defmodule StarWeb.DeliverablesChannel do
  use Phoenix.Channel
	alias Star.DeliverableOperator

  def join("deliverables:join", %{"deliverable" => deliverable_id}, socket) do
		deliverable_id = String.to_integer(deliverable_id)
		deliverable = DeliverableOperator.get_by_id(deliverable_id)
		illustrations = get_illustrations(deliverable)
    {:ok, %{deliverable: deliverable.title, illustrations: illustrations}, socket}
  end

	defp get_illustrations(deliverable) do
		for illustration <- deliverable.illustration do
			%{
				id: illustration.id,
				url: illustration.url
			}
		end
	end
end
