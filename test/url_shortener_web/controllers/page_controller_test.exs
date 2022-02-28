defmodule UrlShortenerWeb.PageControllerTest do
  use UrlShortenerWeb.ConnCase
  alias UrlShortener.{Repo, ShortUrl}

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "<title>SmolURL</title>"
  end

  describe "GET /{slug}" do
    setup [:create_short_url]

    test "renders the home page when no matching url is found for the slug", %{conn: conn} do
      conn = get(conn, "/non-existent-slug")
      assert html_response(conn, 200) =~ "<title>SmolURL</title>"
    end

    test "redirects to the appropriate long url when a matching slug is found", %{
      conn: conn,
      short_url: short_url
    } do
      conn = get(conn, "/#{short_url.slug}")
      assert redirected_to(conn, 302) == short_url.long_url
    end
  end

  defp create_short_url(context) do
    short_url =
      %ShortUrl{long_url: "http://google.com", slug: "existing-slug"}
      |> Repo.insert!()

    Map.put(context, :short_url, short_url)
  end
end
