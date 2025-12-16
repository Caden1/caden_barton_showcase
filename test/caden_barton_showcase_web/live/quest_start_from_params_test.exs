defmodule CadenBartonShowcaseWeb.QuestStartFromParamsTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "activates quest and shows overlay when quest_id param is present", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/hiring-manager?quest_id=hiring_manager")

    assert has_element?(view, "#quest-overlay")
  end
end
