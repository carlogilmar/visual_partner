defmodule Star.AnalyticsUtil do
  @moduledoc """
  Module for get analytics
  """
  alias Star.ViewerOperator
  alias StarWeb.Endpoint

  def get_analytics do
    viewers = ViewerOperator.get_all() |> get_viewers()
    analytics_info = ViewerOperator.get_viewers_info()
    total = ViewerOperator.get_total_viewers()
    analytics = generate_analytics()
    analytics_model =
      viewers
      |> fill_analytics(analytics)
      |> create_series_model()
      |> Enum.reverse()
    {analytics_model, analytics_info, total}
  end

  def update_analytics_dashboard do
    {analytics, info, counter} = get_analytics()
    update = %{analytics: analytics, counter: counter, info: info}
    _ = Endpoint.broadcast("analytics:join", "analytics:broadcast", update)
  end

  defp create_series_model(analytics) do
    for hour <- 0..23 do
      data = get_data(analytics, hour)
      %{name: "#{hour} hrs", data: data}
    end
  end

  defp get_data(analytics, hour) do
    {day_1, counters_1} = analytics[1]
    {day_2, counters_2} = analytics[2]
    {day_3, counters_3} = analytics[3]
    {day_4, counters_4} = analytics[4]
    {day_5, counters_5} = analytics[5]
    {day_6, counters_6} = analytics[6]
    {day_7, counters_7} = analytics[7]
    [
      %{x: "#{day_1}", y: counters_1[hour]},
      %{x: "#{day_2}", y: counters_2[hour]},
      %{x: "#{day_3}", y: counters_3[hour]},
      %{x: "#{day_4}", y: counters_4[hour]},
      %{x: "#{day_5}", y: counters_5[hour]},
      %{x: "#{day_6}", y: counters_6[hour]},
      %{x: "#{day_7}", y: counters_7[hour]}
    ]
  end

  defp fill_analytics([], analytics), do: analytics
  defp fill_analytics([viewer|viewers], analytics) do
    {weekday_name, counters} = analytics[viewer.weekday]
    current_counter = counters[viewer.inserted_at.hour]
    weekday_counter = Map.put(counters, viewer.inserted_at.hour, (current_counter+1))
    analytics_updated = Map.put(analytics, viewer.weekday, {weekday_name, weekday_counter})
    fill_analytics(viewers, analytics_updated)
  end

  defp generate_analytics do
    starter_counter = for hour <- 0..23, do: {hour, 0}
    starter_counter = Map.new(starter_counter)
    weekdays = [
      {1, "Lunes"}, {2, "Martes"}, {3, "Miércoles"},
      {4, "Jueves"}, {5, "Viernes"}, {6, "Sábado"}, {7, "Domingo"}]
    counters = for {weekday, weekday_name} <- weekdays,
      do: {weekday, {weekday_name, starter_counter}}
    Map.new(counters)
  end

  defp get_viewers(viewers) do
    for viewer <- viewers do
      weekday =
        :calendar.day_of_the_week({
          viewer.inserted_at.year,
          viewer.inserted_at.month,
          viewer.inserted_at.day})
      Map.put(viewer, :weekday, weekday)
    end
  end

end
