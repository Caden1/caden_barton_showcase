defmodule CadenBartonShowcaseWeb.StaticFontsTest do
  use ExUnit.Case, async: true

  test "no empty woff2 font assets" do
    fonts_dir = Path.join(File.cwd!(), "priv/static/fonts")

    if File.dir?(fonts_dir) do
      fonts_dir
      |> File.ls!()
      |> Enum.filter(&String.ends_with?(&1, ".woff2"))
      |> Enum.each(fn file ->
        path = Path.join(fonts_dir, file)

        assert {:ok, stat} = File.stat(path)
        assert stat.size > 0, "Empty font file found: #{path}"
      end)
    else
      :ok
    end
  end
end
