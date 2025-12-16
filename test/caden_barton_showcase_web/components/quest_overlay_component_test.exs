defmodule CadenBartonShowcaseWeb.QuestOverlayComponentTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias CadenBartonShowcaseWeb.{QuestContent, QuestOverlayComponent, QuestState}

  test "renders minimized quest button when quest is inactive but selected" do
    quest_state =
      QuestState.new()
      |> Map.put(:quest_id, "developer")
      |> Map.put(:active?, false)

    html =
      render_component(&QuestOverlayComponent.quest_overlay/1,
        quests: QuestContent.quests(),
        quest_state: quest_state
      )

    {:ok, doc} = Floki.parse_document(html)

    assert Floki.find(doc, "#quest-open") != []
  end
end
