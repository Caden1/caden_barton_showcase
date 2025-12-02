defmodule CadenBartonShowcaseWeb.HomeLiveTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "home page renders hero content", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/")

    assert html =~ "Elixir &amp; Phoenix engineer focused on shipping resilient systems"

    assert html =~
             "I design reliable backends, thoughtful frontends, and codebases that age well."

    assert html =~ "See how I work"
    assert html =~ "Recent builds"
  end

  test "CTAs link to how I work and builds pages", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/")

    assert html =~ ~s|href="#{~p"/how-i-work"}"|
    assert html =~ ~s|href="#{~p"/builds"}"|
  end

  test "global navigation shows primary links", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/")

    assert html =~ "Caden Barton"
    assert html =~ "See how I work"
    assert html =~ ~s|href="#{~p"/how-i-work"}"|
    assert html =~ "Recent builds"
    assert html =~ ~s|href="#{~p"/builds"}"|
  end
end
