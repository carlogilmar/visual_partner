defmodule Star.ViewerOperator do
  @moduledoc """
  Viewer operator definition
  """
  import Ecto.Query, only: [from: 2]
  alias Star.Viewer
  alias Star.Repo

  def create_viewer(session) do
    res =
      %Viewer{
        city: session["city"],
        continent: session["continent_name"],
        country: session["country_name"],
        region: session["region"],
        time_zone: session["time_zone"]["name"],
        latitude: session["latitude"],
        longitude: session["longitude"]
      }
      |> Repo.insert()

    res
  end

  def get_all do
    Viewer |> Repo.all()
  end

  def get_viewers_info do
    query =
      from(viewer in Viewer,
        select: [viewer.city, viewer.region, viewer.country, viewer.time_zone]
      )

    query |> Repo.all() |> Enum.uniq()
  end

  def get_total_viewers do
    query = from p in Viewer, select: count("*")
    query |> Repo.one()
  end
end
