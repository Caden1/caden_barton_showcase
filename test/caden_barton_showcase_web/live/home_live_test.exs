defmodule CadenBartonShowcaseWeb.HomeLiveTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "home page renders hero content", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "p", "ELIXIR & PHOENIX · AI-ASSISTED DELIVERY")

    assert has_element?(
             view,
             "h1",
             "I ship resilient Elixir systems with an AI-assisted workflow I trust."
           )

    assert has_element?(
             view,
             "a[phx-hook='ScrollToSectionLink'][data-scroll-target='for-hiring-managers'][href='#for-hiring-managers']",
             "See what you get if you hire me"
           )

    assert has_element?(
             view,
             "a[phx-hook='ScrollToSectionLink'][data-scroll-target='section-how-i-work'][href='#section-how-i-work']",
             "See my AI-assisted workflow"
           )

    assert has_element?(view, "a[href='#{~p"/builds"}']", "Recent builds")
  end

  test "CTAs link to hiring managers, how I work, and builds pages", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(
             view,
             "a[phx-hook='ScrollToSectionLink'][data-scroll-target='for-hiring-managers'][href='#for-hiring-managers']"
           )

    assert has_element?(
             view,
             "a[phx-hook='ScrollToSectionLink'][data-scroll-target='section-how-i-work'][href='#section-how-i-work']"
           )

    assert has_element?(view, "a[href='#{~p"/builds"}']")
  end

  test "global navigation shows primary links", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(
             view,
             "a[phx-hook='ScrollToSectionLink'][data-scroll-target='for-hiring-managers'][href='#for-hiring-managers']",
             "See what you get if you hire me"
           )

    assert has_element?(
             view,
             "a[phx-hook='ScrollToSectionLink'][data-scroll-target='section-how-i-work'][href='#section-how-i-work']",
             "See my AI-assisted workflow"
           )

    assert has_element?(view, "a[href='#{~p"/builds"}']", "Recent builds")
  end

  test "renders start here persona selector", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "h2", "Start here")
    assert has_element?(view, "a[href='#for-hiring-managers']", "I’m a hiring manager")
    assert has_element?(view, "a[href='#section-projects']", "I’m a developer")
    assert has_element?(view, "a[href='#case-study']", "I’m just curious")
  end

  test "hiring manager section is present with correct id", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "section#for-hiring-managers h2", "What you get if you hire me")
  end

  test "combined AI workflow section renders roles and steps", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    html = render(view)
    doc = Floki.parse_document!(html)

    assert has_element?(view, "#section-how-i-work")
    assert has_element?(view, "#principles-section")
    assert has_element?(view, "#engagement-section")
    assert has_element?(view, "#tooling-section")

    steps =
      doc
      |> Floki.find("section#section-ai-delivery-loop ol li")

    assert length(steps) == 9
  end

  test "case study section has correct id and card order", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    html = render(view)
    doc = Floki.parse_document!(html)

    assert has_element?(view, "section#case-study h2", "This site, built with an AI team")

    headings =
      doc
      |> Floki.find("section#case-study article h3")
      |> Enum.map(&Floki.text/1)

    assert Enum.take(headings, 3) == [
             "Production systems I've shipped",
             "Proof over promise",
             "Principles that prevent debt"
           ]
  end
end
