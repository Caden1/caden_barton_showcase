defmodule CadenBartonShowcaseWeb.HowIWorkLiveTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "how I work page renders core sections", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/how-i-work")

    assert has_element?(view, "#how-i-work-heading")
    assert has_element?(view, "#principles-section")
    assert has_element?(view, "#engagement-section")
    assert has_element?(view, "#tooling-section")
  end

  test "how I work page shows global navigation", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/how-i-work")

    assert has_element?(view, "header a[href='#{~p"/"}']")
    assert has_element?(view, "a[href='#{~p"/how-i-work"}']")
    assert has_element?(view, "a[href='#{~p"/builds"}']")
  end
end
