defmodule UrlShortenerWeb.ShorturlControllerTest do
  use UrlShortenerWeb.ConnCase
  alias UrlShortener.{Repo, ShortUrl}

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "<title>SmolURL</title>"
  end

  describe "POST /api/short_url" do
    setup [:create_short_url]

    test "returns an appropriate error when there is no long url", %{conn: conn} do
      conn = post(conn, "/api/short_url", %{"slug" => ""})
      assert json_response(conn, 422)["error"] == "Invalid URL"
    end

    test "returns an appropriate error when the long url is invalid", %{conn: conn} do
      conn = post(conn, "/api/short_url", %{"slug" => "", "long_url" => "google"})
      assert json_response(conn, 422)["error"] == "Invalid URL"
    end

    test "returns an appropriate error when slug already exists", %{conn: conn} do
      conn =
        post(conn, "/api/short_url", %{
          "slug" => "existing-slug",
          "long_url" => "https://google.com"
        })

      assert json_response(conn, 422)["error"] == "Alias is not available"
    end

    test "returns a generic error when something unexpected occurs", %{conn: conn} do
      conn = post(conn, "/api/short_url", %{})

      assert json_response(conn, 500)["error"] == "Something went wrong"
    end

    test "creates a short url when a unique slug is provided", %{conn: conn} do
      conn =
        post(conn, "/api/short_url", %{
          "slug" => "available-slug",
          "long_url" => "https://google.com"
        })

      assert json_response(conn, 201)["long_url"] =~ "https://google.com"
      assert json_response(conn, 201)["slug"] =~ "available-slug"
    end

    test "creates a short url and generates a slug when no slug is provided", %{conn: conn} do
      conn =
        post(conn, "/api/short_url", %{
          "slug" => "",
          "long_url" => "https://yelp.com/reviews"
        })

      assert json_response(conn, 201)["long_url"] =~ "https://yelp.com"
      assert json_response(conn, 201)["slug"] =~ ~r/^[0-9A-Za-z]*$/
    end
  end

  defp create_short_url(context) do
    short_url =
      %ShortUrl{long_url: "http://google.com", slug: "existing-slug"}
      |> Repo.insert!()

    Map.put(context, :short_url, short_url)
  end
end
