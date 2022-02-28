defmodule UrlShortener do
  @moduledoc """
  UrlShortener keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def generate_slug do
    unix_time =
      DateTime.utc_now()
      |> DateTime.to_unix()

    unique_integer = System.unique_integer([:monotonic, :positive])

    integer =
      "#{unix_time}#{unique_integer}"
      |> String.to_integer()

    Base62.encode(integer)
  end
end
