defmodule Scaffolding do
  def generate_model(model_name) do
    app_name = "star"
    app_capitalized = String.capitalize(app_name)
    model_name_capitalized = capitalize_name(model_name)

    attrs = [
      app_name: app_capitalized,
      model_name: model_name_capitalized
    ]

    files_to_generate = [
      {"scaffolding/model.eex", "lib/#{app_name}/models/#{model_name}.ex"},
      {"scaffolding/operator.eex", "lib/#{app_name}/operators/#{model_name}_operator.ex"},
      {"scaffolding/live_crud.eex", "lib/#{app_name}_web/live/crud_live.ex"}
    ]

    Enum.each(files_to_generate, fn {file, path} ->
      IO.puts("\n Construyendo archivo #{file}")
      template = File.stream!(Path.join(:code.priv_dir(:star), file))
      {:ok, body} = template.path |> File.read()
      content = EEx.eval_string(body, attrs)
      IO.inspect(path)

      :ok = File.write(path, content)
    end)

    IO.puts("\n Construyendo archivo html scaffolding...")
    template = File.stream!(Path.join(:code.priv_dir(:star), "scaffolding/html_crud.eex"))
    {:ok, body} = template.path |> File.read()
    :ok = File.write("lib/#{app_name}_web/templates/crud.html.leex", body)
  end

  def capitalize_name(name) do
    words = String.replace(name, "_", " ") |> String.split(" ")
    words = for w <- words, do: String.capitalize(w)
    words |> Enum.join("")
  end
end
