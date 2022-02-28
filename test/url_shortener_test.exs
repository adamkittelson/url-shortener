defmodule UrlShortenerTest do
  use ExUnit.Case, async: true

  describe "slug generation" do
    setup [:generate_slugs]

    test "slugs are base 62 (numbers, lower case letters, capital letters)", %{slugs: slugs} do
      Enum.each(slugs, fn slug ->
        assert slug =~ ~r/^[0-9A-Za-z]*$/
      end)
    end

    test "slugs are unique", %{slugs: slugs} do
      assert length(slugs) == length(Enum.uniq(slugs))
    end
  end

  defp generate_slugs(context) do
    slugs = Enum.map(1..1000, fn _n -> UrlShortener.generate_slug() end)

    Map.put(context, :slugs, slugs)
  end
end
