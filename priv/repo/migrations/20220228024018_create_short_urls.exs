defmodule UrlShortener.Repo.Migrations.CreateShortUrls do
  use Ecto.Migration

  def change do
    create table(:short_urls) do
      add :long_url, :text
      add :slug, :text

      timestamps()
    end

    create(unique_index(:short_urls, [:slug]))
  end
end
