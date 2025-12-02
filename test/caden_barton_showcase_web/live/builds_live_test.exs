defmodule CadenBartonShowcaseWeb.BuildsLiveTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "builds index renders heading and list", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/builds")

    assert has_element?(view, "#builds-heading")
    assert has_element?(view, "#builds-list")
    assert has_element?(view, "#builds-list [data-role='build-card']")
  end

  test "builds index links to project detail pages structurally", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/builds")

    assert has_element?(view, "a[href='#{~p"/builds/realtime-ops-console"}']")
    assert has_element?(view, "a[href='#{~p"/builds/event-pipeline"}']")
  end

  test "builds index shows global navigation structurally", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/builds")

    assert has_element?(view, "header a[href='#{~p"/"}']")
    assert has_element?(view, "a[href='#{~p"/how-i-work"}']")
    assert has_element?(view, "a[href='#{~p"/builds"}']")
  end
end
