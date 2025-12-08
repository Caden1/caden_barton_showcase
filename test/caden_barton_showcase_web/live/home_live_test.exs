defmodule CadenBartonShowcaseWeb.HomeLiveTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "home page renders hero content", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "p", "ELIXIR & PHOENIX · AI-ASSISTED DELIVERY")

    assert has_element?(
             view,
             "h1",
             "I conduct AI-powered engineering teams that ship resilient systems."
           )

    assert has_element?(
             view,
             "a[phx-hook='ScrollToSectionLink'][data-scroll-target='for-hiring-managers'][href='#for-hiring-managers']",
             "See what you get if you hire me"
           )

    assert has_element?(
             view,
             "a[phx-hook='ScrollToSectionLink'][data-scroll-target='section-how-i-work'][href='#section-how-i-work']",
             "See AI conductor workflow"
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
             "See AI conductor workflow"
           )

    assert has_element?(view, "a[href='#{~p"/builds"}']", "Recent builds")
  end

  test "renders start here persona selector", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "h2", "Start here")
    assert has_element?(view, "article[phx-value-persona='recruiter']", "I’m a hiring manager")
    assert has_element?(view, "article[phx-value-persona='developer']", "I’m a developer")
    assert has_element?(view, "article[phx-value-persona='curious']", "I’m just curious")
  end

  test "hiring manager section is present with correct id", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "section#for-hiring-managers h2", "What you get if you hire me")
  end

  test "clicking developer persona highlights selection and pushes scroll event", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    render_click(element(view, "article[phx-value-persona='developer']"))

    html = render(view)

    developer_classes =
      html
      |> Floki.parse_document!()
      |> Floki.find("article[phx-value-persona='developer']")
      |> Floki.attribute("class")
      |> List.first()

    assert developer_classes =~ "border-emerald-400/80"
    assert_push_event(view, "scroll_to_section", %{target_id: "section-projects"})
  end
end
