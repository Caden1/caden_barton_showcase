defmodule CadenBartonShowcaseWeb.HowIWorkLiveTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "how I work page renders core sections", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/how-i-work")

    assert has_element?(view, "h1", "How I work")
    assert has_element?(view, "*", "Principles")
    assert has_element?(view, "*", "Engagement")
    assert has_element?(view, "*", "Tooling")
    assert has_element?(view, "*", "resilient backends")
  end

  test "how I work page shows global navigation", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/how-i-work")

    assert has_element?(view, "*", "Caden Barton")
    assert has_element?(view, "a[href='#{~p"/how-i-work"}']", "How I work")
    assert has_element?(view, "a[href='#{~p"/builds"}']", "Builds")
  end
end
