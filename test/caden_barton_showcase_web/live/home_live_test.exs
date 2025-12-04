defmodule CadenBartonShowcaseWeb.HomeLiveTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "home page renders hero content", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "p", "ELIXIR & PHOENIX · AI-ASSISTED DELIVERY")
    assert has_element?(view, "h1", "I conduct AI-powered engineering teams that ship resilient systems.")
    assert has_element?(view, "a[href='#{~p"/#section-how-i-work"}']", "See AI conductor workflow")
    assert has_element?(view, "a[href='#{~p"/builds"}']", "Recent builds")
  end

  test "CTAs link to how I work and builds pages", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "a[href='#{~p"/#section-how-i-work"}']")
    assert has_element?(view, "a[href='#{~p"/builds"}']")
  end

  test "global navigation shows primary links", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "a[href='#{~p"/#section-how-i-work"}']", "See AI conductor workflow")
    assert has_element?(view, "a[href='#{~p"/builds"}']", "Recent builds")
  end
end
