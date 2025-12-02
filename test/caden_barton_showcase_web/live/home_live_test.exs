defmodule CadenBartonShowcaseWeb.HomeLiveTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "home page renders hero content", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "p", "Elixir & Phoenix engineer")
    assert has_element?(view, "h1", "I design reliable backends")
    assert has_element?(view, "a[href='#{~p"/how-i-work"}']", "See how I work")
    assert has_element?(view, "a[href='#{~p"/builds"}']", "Recent builds")
  end

  test "CTAs link to how I work and builds pages", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "a[href='#{~p"/how-i-work"}']")
    assert has_element?(view, "a[href='#{~p"/builds"}']")
  end

  test "global navigation shows primary links", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "a[href='#{~p"/how-i-work"}']", "See how I work")
    assert has_element?(view, "a[href='#{~p"/builds"}']", "Recent builds")
  end
end
