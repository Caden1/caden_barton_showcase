defmodule CadenBartonShowcaseWeb.QuestHooks do
  @moduledoc false

  import Phoenix.Component, only: [assign: 3, assign_new: 3]
  import Phoenix.LiveView

  alias CadenBartonShowcaseWeb.QuestContent
  alias CadenBartonShowcaseWeb.QuestState

  def on_mount(:public, _params, _session, socket) do
    socket =
      socket
      |> assign_new(:quest_state, fn -> QuestState.new() end)
      |> assign_new(:quests, fn -> QuestContent.quests() end)
      |> assign_new(:pending_unlock, fn -> nil end)
      |> attach_hook(:quest_handle_event, :handle_event, &handle_event/3)
      |> attach_hook(:quest_handle_params, :handle_params, &handle_params/3)

    {:cont, socket}
  end

  defp handle_params(params, _uri, socket) do
    socket =
      socket
      |> assign(:pending_unlock, unlock_from_params(params))
      |> maybe_apply_pending_unlock()

    {:cont, socket}
  end

  defp handle_event("quest_start", %{"quest_id" => quest_id}, socket) do
    {:halt, assign_and_save(socket, QuestState.start(socket.assigns.quest_state, quest_id))}
  end

  defp handle_event("quest_toggle_step", %{"step_id" => step_id}, socket) do
    new_state =
      socket.assigns.quest_state
      |> QuestState.toggle_step(step_id)
      |> add_unlocks_for_progress(socket.assigns.quests)

    {:halt, assign_and_save(socket, new_state)}
  end

  defp handle_event("quest_reset", _params, socket) do
    {:halt, assign_and_save(socket, QuestState.reset(socket.assigns.quest_state))}
  end

  defp handle_event("quest_open", _params, socket) do
    %{quest_state: quest_state, quests: quests} = socket.assigns

    case quest_state.quest_id do
      nil ->
        {:cont, socket}

      quest_id ->
        if Map.has_key?(quests, quest_id) do
          {:halt, assign_and_save(socket, Map.put(quest_state, :active?, true))}
        else
          {:cont, socket}
        end
    end
  end

  defp handle_event("quest_close", _params, socket) do
    {:halt, assign_and_save(socket, Map.put(socket.assigns.quest_state, :active?, false))}
  end

  defp handle_event("quest_step_seen", %{"target_id" => target_id}, socket) do
    new_state =
      socket.assigns.quest_state
      |> maybe_mark_step_seen(target_id, socket.assigns.quests)
      |> add_unlocks_for_progress(socket.assigns.quests)

    {:halt, assign_and_save(socket, new_state)}
  end

  defp handle_event("quest_state_loaded", %{"state" => state}, socket) do
    {:halt, assign_and_save(socket, QuestState.sanitize_loaded(state))}
  end

  defp handle_event("QuestPersistence", %{"state" => state}, socket),
    do: handle_event("quest_state_loaded", %{"state" => state}, socket)

  defp handle_event("event", %{"state" => state}, socket),
    do: handle_event("quest_state_loaded", %{"state" => state}, socket)

  defp handle_event(_event, _params, socket), do: {:cont, socket}

  defp assign_and_save(socket, state) do
    state = add_unlocks_for_progress(state, socket.assigns.quests)

    socket
    |> assign(:quest_state, state)
    |> push_quest_state_save()
  end

  defp push_quest_state_save(%{assigns: %{quest_state: state}} = socket) do
    push_event(socket, "quest_state_save", %{state: quest_state_payload(state)})
  end

  defp quest_state_payload(state) do
    state
    |> Map.update!(:completed_step_ids, &MapSet.to_list/1)
    |> Map.update!(:unlocked_ids, &MapSet.to_list/1)
  end

  defp add_unlocks_for_progress(%{quest_id: nil} = state, _quests), do: state

  defp add_unlocks_for_progress(%{quest_id: quest_id} = state, quests) do
    completed_count = MapSet.size(state.completed_step_ids)

    total_steps =
      quests
      |> Map.get(quest_id, %{})
      |> Map.get(:steps, [])
      |> length()

    unlocks =
      state.unlocked_ids
      |> MapSet.new()
      |> maybe_put_unlock(completed_count >= 2, "proof-signals")
      |> maybe_put_unlock(completed_count >= 4, "proof-workflow")
      |> maybe_put_unlock(total_steps > 0 && completed_count >= total_steps, "proof-case-study")

    %{state | unlocked_ids: unlocks}
  end

  defp maybe_put_unlock(unlocks, true, id), do: MapSet.put(unlocks, id)
  defp maybe_put_unlock(unlocks, false, _id), do: unlocks

  defp maybe_mark_step_seen(%{quest_id: nil} = state, _target_id, _quests), do: state

  defp maybe_mark_step_seen(%{quest_id: quest_id} = state, target_id, quests) do
    case QuestState.step_id_for_target(quests, quest_id, target_id) do
      nil ->
        state

      step_id ->
        if MapSet.member?(state.completed_step_ids, step_id) do
          state
        else
          state
          |> Map.update!(:completed_step_ids, &MapSet.put(&1, step_id))
          |> Map.update!(:unlocked_ids, &MapSet.put(&1, step_id))
        end
    end
  end

  defp unlock_from_params(%{"unlock" => "incident_winner"}), do: "incident-winner"
  defp unlock_from_params(_params), do: nil

  defp maybe_apply_pending_unlock(%{assigns: %{pending_unlock: nil}} = socket), do: socket

  defp maybe_apply_pending_unlock(
         %{assigns: %{pending_unlock: unlock, quest_state: quest_state}} = socket
       ) do
    if MapSet.member?(quest_state.unlocked_ids, unlock) do
      socket
    else
      quest_state = Map.update!(quest_state, :unlocked_ids, &MapSet.put(&1, unlock))

      socket
      |> assign(:pending_unlock, nil)
      |> assign_and_save(quest_state)
    end
  end
end
