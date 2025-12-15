defmodule CadenBartonShowcaseWeb.IncidentSimulatorLiveTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "completing steps in order shows victory", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/simulator/incident")

    view
    |> element("#incident-action-check-metrics")
    |> render_click()

    view
    |> element("#incident-action-enable-flag")
    |> render_click()

    view
    |> element("#incident-action-rollback")
    |> render_click()

    assert has_element?(view, "h2", "Victory! Incident contained.")
    assert has_element?(view, "a", "Return home")
  end
end
