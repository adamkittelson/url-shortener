defmodule UrlShortenerWeb.ApiController do
  use UrlShortenerWeb, :controller

  def create(conn, params) do
    IO.inspect(params)

    conn
    |> put_status(:created)
    |> json(%{url: "https://localhost:4000/aD3cs7"})
  end
end
