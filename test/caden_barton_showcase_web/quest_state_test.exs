defmodule CadenBartonShowcaseWeb.QuestStateTest do
  use ExUnit.Case, async: true

  alias CadenBartonShowcaseWeb.QuestState

  describe "sanitize_loaded/1" do
    test "keeps valid quest and filters unknown step ids" do
      raw = %{
        "version" => 99,
        "active?" => true,
        "quest_id" => "developer",
        "completed_step_ids" => ["dev-workflow", "unknown"],
        "unlocked_ids" => ["dev-workflow", "other"]
      }

      state = QuestState.sanitize_loaded(raw)

      assert state.version == 1
      assert state.active?
      assert state.quest_id == "developer"
      assert state.completed_step_ids == MapSet.new(["dev-workflow"])
      assert state.unlocked_ids == MapSet.new(["dev-workflow"])
    end

    test "resets to default for unknown quest" do
      raw = %{"active?" => true, "quest_id" => "nope", "completed_step_ids" => ["dev-workflow"]}

      assert QuestState.sanitize_loaded(raw) == QuestState.new()
    end
  end

  describe "toggle_step/2" do
    test "toggles membership for a valid step" do
      state = QuestState.start(QuestState.new(), "developer")
      toggled = QuestState.toggle_step(state, "dev-workflow")

      assert MapSet.member?(toggled.completed_step_ids, "dev-workflow")
      assert MapSet.member?(toggled.unlocked_ids, "dev-workflow")

      reverted = QuestState.toggle_step(toggled, "dev-workflow")

      refute MapSet.member?(reverted.completed_step_ids, "dev-workflow")
      refute MapSet.member?(reverted.unlocked_ids, "dev-workflow")
    end

    test "ignores steps not in the quest" do
      state = QuestState.start(QuestState.new(), "developer")
      assert QuestState.toggle_step(state, "missing-step") == state
    end
  end

  describe "step_id_for_target/3" do
    test "finds a step id for a target id" do
      quests = CadenBartonShowcaseWeb.QuestContent.quests()

      assert QuestState.step_id_for_target(quests, "hiring_manager", "section-ai-delivery-loop") ==
               "hm-ai-loop"
    end

    test "returns nil for unknown target" do
      quests = CadenBartonShowcaseWeb.QuestContent.quests()

      assert QuestState.step_id_for_target(quests, "hiring_manager", "missing-section") == nil
    end
  end
end
