defmodule CadenBartonShowcaseWeb.HiringManagerTourState do
  @moduledoc false

  alias CadenBartonShowcaseWeb.HiringManagerTourContent

  defstruct active?: false,
            current_step_id: nil,
            completed_step_ids: MapSet.new(),
            skipped_step_ids: MapSet.new()

  def new, do: %__MODULE__{}

  def start(_state \\ nil, steps \\ HiringManagerTourContent.steps()) do
    case steps do
      [%{id: first_id} | _] ->
        %__MODULE__{
          active?: true,
          current_step_id: first_id,
          completed_step_ids: MapSet.new(),
          skipped_step_ids: MapSet.new()
        }

      _ ->
        new()
    end
  end

  def complete(%__MODULE__{active?: true, current_step_id: current} = state, steps)
      when is_binary(current) do
    state
    |> Map.update!(:completed_step_ids, &MapSet.put(&1, current))
    |> advance(steps)
  end

  def complete(state, _steps), do: state

  def skip(%__MODULE__{active?: true, current_step_id: current} = state, steps)
      when is_binary(current) do
    state
    |> Map.update!(:skipped_step_ids, &MapSet.put(&1, current))
    |> advance(steps)
  end

  def skip(state, _steps), do: state

  def exit, do: new()

  def sanitize_loaded(map, steps \\ HiringManagerTourContent.steps()) do
    step_ids = MapSet.new(Enum.map(steps, & &1.id))

    completed =
      map
      |> fetch_list(:completed_step_ids)
      |> Enum.filter(&MapSet.member?(step_ids, &1))
      |> MapSet.new()

    skipped =
      map
      |> fetch_list(:skipped_step_ids)
      |> Enum.filter(&MapSet.member?(step_ids, &1))
      |> MapSet.new()

    active? = fetch_boolean(map, :active?)
    current = fetch_current(map, step_ids)

    %__MODULE__{
      active?: active? && not Enum.empty?(steps),
      current_step_id: normalize_current(current, steps, completed, skipped, active?),
      completed_step_ids: completed,
      skipped_step_ids: skipped
    }
  end

  defp advance(state, steps) do
    next =
      steps
      |> Enum.map(& &1.id)
      |> next_after(state.current_step_id)

    %{state | current_step_id: next}
  end

  defp next_after(step_ids, current) do
    case Enum.drop_while(step_ids, &(&1 != current)) do
      [_current, next | _] -> next
      _ -> nil
    end
  end

  defp fetch_boolean(map, key) do
    case Map.get(map, key) || Map.get(map, Atom.to_string(key)) do
      true -> true
      false -> false
      _ -> false
    end
  end

  defp fetch_list(map, key) do
    case Map.get(map, key) || Map.get(map, Atom.to_string(key)) do
      list when is_list(list) -> list
      _ -> []
    end
  end

  defp fetch_current(map, step_ids) do
    current = Map.get(map, :current_step_id) || Map.get(map, "current_step_id")
    if is_binary(current) && MapSet.member?(step_ids, current), do: current, else: nil
  end

  defp normalize_current(current, steps, completed, skipped, true) do
    ids = Enum.map(steps, & &1.id)

    cond do
      current && current in ids ->
        current

      ids == [] ->
        nil

      true ->
        ids
        |> Enum.find(fn id ->
          not MapSet.member?(completed, id) and not MapSet.member?(skipped, id)
        end)
        |> Kernel.||(List.first(ids))
    end
  end

  defp normalize_current(_current, _steps, _completed, _skipped, _active?), do: nil
end
