defmodule UrlShortenerWeb.ShortUrlController do
  use UrlShortenerWeb, :controller
  alias UrlShortener.{Repo, ShortUrl}
  require Logger

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

      {:error, %Ecto.Changeset{errors: [slug: {error, _}]}} ->
        Logger.info("Slug Error: #{inspect(error)}")

        conn
        |> put_status(:unprocessable_entity)
        |> json(%{"error" => "Alias is not available"})

      {:error, %Ecto.Changeset{errors: [long_url: {error, _}]}} ->
        Logger.info("Long URL Error: #{inspect(error)}")

        conn
        |> put_status(:unprocessable_entity)
        |> json(%{"error" => "Invalid URL"})

      _other ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{"error" => "Something went wrong"})
    end
  end
end
