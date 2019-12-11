defmodule Mix.Tasks.CreateModel do
  use Mix.Task

  def run([model_name]) do
    Scaffolding.generate_model(model_name)
  end
end
