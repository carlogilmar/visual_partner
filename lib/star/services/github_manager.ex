defmodule Star.GitHubManager do
  @github_api Application.get_env(:star, StarWeb.Endpoint)[:github_api_key]
  @repo_url "https://api.github.com/repos/carlogilmar/star/commits"

  def get_commits() do
    headers = [
      {:"Authorization", @github_api},
      {:"Content-Type", "application/vnd.github.mercy-preview+json"}]
    {:ok, response} = HTTPoison.get(@repo_url, headers)
    decode_response.(response.body)
  end

  defp decode_response do
    fn response ->
      {:ok, body} = Poison.decode(response)
      parse_commit_response(body)
    end
  end

  defp parse_commit_response(response) do
    for commit <- response do
      %{
        desc: commit["commit"]["message"],
        date: commit["commit"]["author"]["date"],
        url: commit["html_url"],
        author: commit["author"]["login"],
        author_profile: commit["author"]["html_url"]
      }
    end
  end
end

