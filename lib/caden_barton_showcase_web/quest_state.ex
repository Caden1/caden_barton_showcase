defmodule CadenBartonShowcaseWeb.QuestState do
  @moduledoc false

  alias CadenBartonShowcaseWeb.QuestContent

  def new do
    %{
      version: 1,
      active?: false,
      quest_id: nil,
      completed_step_ids: MapSet.new(),
      unlocked_ids: MapSet.new()
    }
  end

  def start(_state, quest_id) do
    if quest_exists?(quest_id) do
      %{new() | active?: true, quest_id: quest_id}
    else
      new()
    end
  end

  def toggle_step(%{quest_id: nil} = state, _step_id), do: state

  def toggle_step(state, step_id) do
    if valid_step?(state.quest_id, step_id) do
      state
      |> toggle_in_set(:completed_step_ids, step_id)
      |> toggle_in_set(:unlocked_ids, step_id)
    else
      state
    end
  end

  def reset(_state), do: new()

  def step_id_for_target(quests, quest_id, target_id) when is_binary(target_id) do
    quests
    |> Map.get(quest_id, %{})
    |> Map.get(:steps, [])
    |> Enum.find_value(fn
      %{target_id: ^target_id, id: id} -> id
      _ -> nil
    end)
  end

  def step_id_for_target(_quests, _quest_id, _target_id), do: nil

  def sanitize_loaded(map) when is_map(map) do
    quest_id = fetch_quest_id(map)
    allowed_steps = step_ids_for(quest_id)

    base = new()

    if quest_id do
      %{
        base
        | active?: fetch_boolean(map, :active?) && quest_id != nil,
          quest_id: quest_id,
          completed_step_ids:
            map
            |> fetch_set(:completed_step_ids)
            |> MapSet.intersection(allowed_steps),
          unlocked_ids:
            map
            |> fetch_set(:unlocked_ids)
            |> MapSet.intersection(allowed_steps)
      }
    else
      base
    end
  end

  def sanitize_loaded(_), do: new()

  defp toggle_in_set(state, key, value) do
    Map.update!(state, key, fn set ->
      if MapSet.member?(set, value) do
        MapSet.delete(set, value)
      else
        MapSet.put(set, value)
      end
    end)
  end

  defp quest_exists?(quest_id), do: Map.has_key?(QuestContent.quests(), quest_id)

  defp valid_step?(quest_id, step_id) do
    quest_id && MapSet.member?(step_ids_for(quest_id), step_id)
  end

  defp step_ids_for(nil), do: MapSet.new()

  defp step_ids_for(quest_id) do
    QuestContent.quests()
    |> Map.get(quest_id, %{})
    |> Map.get(:steps, [])
    |> Enum.map(& &1.id)
    |> MapSet.new()
  end

  defp fetch_quest_id(map) do
    quest_id =
      case Map.get(map, :quest_id) do
        nil -> Map.get(map, "quest_id")
        other -> other
      end

    if is_binary(quest_id) && quest_exists?(quest_id), do: quest_id, else: nil
  end

  defp fetch_set(map, key) do
    map
    |> fetch_value(key)
    |> to_set()
  end

  defp fetch_boolean(map, key) do
    case fetch_value(map, key) do
      true -> true
      false -> false
      _ -> false
    end
  end

  defp fetch_value(map, key) do
    case Map.get(map, key) do
      nil -> Map.get(map, Atom.to_string(key))
      other -> other
    end
  end

  defp to_set(%MapSet{} = set), do: set
  defp to_set(list) when is_list(list), do: MapSet.new(list)
  defp to_set(_), do: MapSet.new()
end
