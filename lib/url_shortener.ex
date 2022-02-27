defmodule UrlShortener do
  @moduledoc """
  UrlShortener keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def generate_slug(id) do
    unix_time =
      DateTime.utc_now()
      |> DateTime.to_unix()

    integer =
      "#{unix_time}#{id}"
      |> String.to_integer()

    Base62.encode(integer)
  end
end
