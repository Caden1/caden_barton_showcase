defmodule CadenBartonShowcaseWeb.HomeLiveTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "home page renders hero content", %{conn: conn} do
    {:ok, view, _html} = live(conn, home_path())

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

    assert has_element?(
             view,
             "a[phx-hook='ScrollToSectionLink'][data-scroll-target='section-builds'][href='#section-builds']",
             "Recent builds"
           )
  end

  test "CTAs link to hiring managers, how I work, and builds pages", %{conn: conn} do
    {:ok, view, _html} = live(conn, home_path())

    assert has_element?(
             view,
             "a[phx-hook='ScrollToSectionLink'][data-scroll-target='for-hiring-managers'][href='#for-hiring-managers']"
           )

    assert has_element?(
             view,
             "a[phx-hook='ScrollToSectionLink'][data-scroll-target='section-how-i-work'][href='#section-how-i-work']"
           )

    assert has_element?(
             view,
             "a[phx-hook='ScrollToSectionLink'][data-scroll-target='section-builds'][href='#section-builds']"
           )
  end

  test "renders start here persona selector", %{conn: conn} do
    {:ok, view, _html} = live(conn, home_path())

    assert has_element?(view, "h2", "Start here")
    assert has_element?(view, "a[href='#for-hiring-managers']", "I'm a hiring manager")
    assert has_element?(view, "a[href='#case-study']", "I'm a developer")
    assert has_element?(view, "a[href='#section-builds']", "I'm just curious")
  end

  test "hiring manager section is present with correct id", %{conn: conn} do
    {:ok, view, _html} = live(conn, home_path())

    assert has_element?(view, "section#for-hiring-managers h2", "What you get if you hire me")
  end

  test "combined AI workflow section renders roles and steps", %{conn: conn} do
    {:ok, view, _html} = live(conn, home_path())

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

  test "home page shows recent builds section with links to case studies", %{conn: conn} do
    {:ok, view, _html} = live(conn, home_path())

    assert has_element?(view, "#section-builds")
    assert has_element?(view, "#builds-list [data-role='build-card']")
    assert has_element?(view, "a[href='#{~p"/builds/realtime-ops-console"}']", "Read more →")
    assert has_element?(view, "a[href='#{~p"/builds/event-pipeline"}']", "Read more →")
    assert has_element?(view, "a[href='#{~p"/builds/multitenant-api"}']", "Read more →")
  end

  test "case study section has correct id and card order", %{conn: conn} do
    {:ok, view, _html} = live(conn, home_path())

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

  test "quest mode can be started and steps toggled", %{conn: conn} do
    {:ok, view, _html} = live(conn, home_path())

    refute has_element?(view, "#quest-overlay")

    view
    |> element("#quest-start-hiring-manager")
    |> render_click()

    assert has_element?(view, "#quest-overlay")

    progress0 =
      view
      |> render()
      |> Floki.parse_document!()
      |> Floki.find("#quest-progress")
      |> Floki.text()
      |> String.trim()

    assert progress0 =~ "0/5"

    view
    |> element("#quest-step-toggle-hm-fit")
    |> render_click()

    progress1 =
      view
      |> render()
      |> Floki.parse_document!()
      |> Floki.find("#quest-progress")
      |> Floki.text()
      |> String.trim()

    assert progress1 =~ "1/5"
  end

  test "quest state loaded event restores quest overlay", %{conn: conn} do
    {:ok, view, _html} = live(conn, home_path())
    refute has_element?(view, "#quest-overlay")

    render_hook(view, "QuestPersistence", %{
      "state" => %{
        "active?" => true,
        "quest_id" => "developer",
        "completed_step_ids" => ["dev-workflow"],
        "unlocked_ids" => ["dev-workflow", "invalid"]
      }
    })

    html = render(view)
    assert has_element?(view, "#quest-overlay")
    assert html =~ "Pair with the stack"
    assert html =~ "1/4"
  end

  test "proof cards unlock after completing steps", %{conn: conn} do
    {:ok, view, _html} = live(conn, home_path())

    assert has_element?(view, "#proof-card-proof-signals [data-status='locked']", "Locked")

    view
    |> element("#quest-start-hiring-manager")
    |> render_click()

    view
    |> element("#quest-step-toggle-hm-fit")
    |> render_click()

    view
    |> element("#quest-step-toggle-hm-workflow")
    |> render_click()

    assert has_element?(view, "#proof-card-proof-signals [data-status='unlocked']", "Unlocked")
  end

  test "incident simulator unlock param unlocks proof card", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/home?unlock=incident_winner")

    assert has_element?(view, "#proof-card-incident-winner [data-status='unlocked']", "Unlocked")
  end

  defp home_path, do: ~p"/home"
end
