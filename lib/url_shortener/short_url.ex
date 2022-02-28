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
    |> validate_change(:long_url, fn :long_url, long_url ->
      long_url = URI.parse(long_url)

      if Enum.any?([:host, :scheme], &is_nil(Map.get(long_url, &1))) do
        [long_url: "Invalid URL"]
      else
        []
      end
    end)
    |> unique_constraint(:slug)
  end
end
