defmodule CadenBartonShowcaseWeb.WelcomeLiveTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders typed intro with skip control", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "#welcome-typewriter[phx-hook='Typewriter'][aria-live='polite']")
    assert has_element?(view, "#skip-intro", "Skip intro")
    assert has_element?(view, "p", "Ready to see how I deliver?")
  end

  test "shows CTAs after skipping intro", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "#cta-hiring-manager-tour")

    view
    |> element("#skip-intro")
    |> render_click()

    assert has_element?(view, "#cta-hiring-manager-tour", "Hiring Manager Guided Tour")
    assert has_element?(view, "#cta-browse-builds", "Browse builds")
  end
end
