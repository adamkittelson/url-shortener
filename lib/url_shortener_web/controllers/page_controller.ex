defmodule UrlShortenerWeb.PageController do
  use UrlShortenerWeb, :controller
  alias UrlShortener.{Repo, ShortUrl}

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"slug" => slug} = params) do
    ShortUrl
    |> Repo.get_by(slug: slug)
    |> case do
      %ShortUrl{long_url: url} ->
        redirect(conn, external: url)

      nil ->
        index(conn, params)
    end
  end
end
