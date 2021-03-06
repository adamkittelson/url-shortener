defmodule UrlShortenerWeb.Router do
  use UrlShortenerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {UrlShortenerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UrlShortenerWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/:slug", PageController, :show
  end

  scope "/api", UrlShortenerWeb do
    pipe_through :api

    post "/short_url", ShortUrlController, :create
  end
end
