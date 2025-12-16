defmodule CadenBartonShowcaseWeb.WelcomeLiveTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders typed intro with skip control", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "#welcome-typewriter[phx-hook='Typewriter'][aria-live='polite']")
    assert has_element?(view, "#skip-intro", "Skip intro")
    assert has_element?(view, "p", "What brings you here?")
  end

  test "reveals persona options after skipping intro", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    refute has_element?(view, "#persona-hiring-manager")

    view
    |> element("#skip-intro")
    |> render_click()

    assert has_element?(view, "#persona-hiring-manager", "Hiring Manager")
    assert has_element?(view, "#persona-developer", "Developer")
    assert has_element?(view, "#persona-curious", "Just Curious")
  end
end
