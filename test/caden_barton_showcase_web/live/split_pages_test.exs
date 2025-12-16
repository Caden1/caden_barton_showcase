defmodule CadenBartonShowcaseWeb.SplitPagesTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "hiring manager page shows promises and back link", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/hiring-manager")

    assert has_element?(view, "h1", "What you get if you hire me")
    assert has_element?(view, "a[href='#{~p"/"}']", "Back to Home")
  end

  test "AI delivery loop page lists steps", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/ai-delivery-loop")

    assert has_element?(view, "h1", "How I work with an AI team")

    html = render(view)
    {:ok, doc} = Floki.parse_document(html)

    steps = Floki.find(doc, "ol li")
    assert length(steps) == 9
  end

  test "case study page renders key cards", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/case-study")

    assert has_element?(view, "h1", "This site, built with an AI team")
    assert has_element?(view, "a[href='#{~p"/"}']", "Back to Home")
    assert has_element?(view, "article h3", "Production systems I've shipped")
  end

  test "projects page lists builds", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/projects")

    assert has_element?(view, "h1", "Selected projects")
    assert has_element?(view, "#builds-list [data-role='build-card']")
  end
end
