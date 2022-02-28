defmodule UrlShortener.ShortUrl do
  use Ecto.Schema
  import Ecto.Changeset

  schema "short_urls" do
    field :long_url, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(short_url, attrs) do
    short_url
    |> cast(attrs, [:long_url, :slug])
    |> validate_required([:long_url, :slug])
    |> unique_constraint(:slug)
  end
end
