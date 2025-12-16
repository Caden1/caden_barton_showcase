defmodule CadenBartonShowcaseWeb.PageControllerTest do
  use CadenBartonShowcaseWeb.ConnCase

  import Phoenix.LiveViewTest

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    html = html_response(conn, 200)

    assert html =~ "What brings you here?"
    assert html =~ "Skip intro"
  end

  test "GET /how-i-work renders workflow page", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/how-i-work")

    assert has_element?(view, "h1", "How I work")
    assert has_element?(view, "a[href='#{~p"/"}']", "Back to Home")
  end

  test "GET /builds renders builds index", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/builds")

    assert has_element?(view, "#builds-list [data-role='build-card']")
    assert has_element?(view, "a[href='#{~p"/"}']", "Back to Home")
  end
end
