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
             "a[href='#{~p"/hiring-manager"}']",
             "See what you get if you hire me"
           )

    assert has_element?(
             view,
             "a[href='#{~p"/how-i-work"}']",
             "See my AI-assisted workflow"
           )

    assert has_element?(
             view,
             "a[href='#{~p"/builds"}']",
             "Recent builds"
           )
  end

  test "CTAs link to hiring managers, how I work, and builds pages", %{conn: conn} do
    {:ok, view, _html} = live(conn, home_path())

    assert has_element?(
             view,
             "a[href='#{~p"/hiring-manager"}']"
           )

    assert has_element?(
             view,
             "a[href='#{~p"/how-i-work"}']"
           )

    assert has_element?(
             view,
             "a[href='#{~p"/builds"}']"
           )
  end

  test "renders start here persona selector", %{conn: conn} do
    {:ok, view, _html} = live(conn, home_path())

    assert has_element?(view, "h2", "Start here")
    assert has_element?(view, "a[href='#{~p"/hiring-manager"}']", "I'm a hiring manager")
    assert has_element?(view, "a[href='#{~p"/case-study"}']", "I'm a developer")
    assert has_element?(view, "a[href='#{~p"/projects"}']", "I'm just curious")
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
