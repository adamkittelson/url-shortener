defmodule UrlShortenerWeb.ApiController do
  use UrlShortenerWeb, :controller
  alias UrlShortener.{Repo, ShortUrl}

  def create(conn, %{"slug" => ""} = params) do
    slug = UrlShortener.generate_slug()

    create(conn, %{params | "slug" => slug})
  end

  def create(conn, params) do
    %ShortUrl{}
    |> ShortUrl.changeset(params)
    |> Repo.insert()
    |> case do
      {:ok, short_url} ->
        conn
        |> put_status(:created)
        |> json(%{slug: short_url.slug, long_url: short_url.long_url})

      {:error, %Ecto.Changeset{errors: [slug: {"has already been taken", _}]}} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{"error" => "Alias is not available"})

      _other ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{"error" => "Something went wrong"})
    end
  end
end
