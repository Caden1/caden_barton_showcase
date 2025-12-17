defmodule CadenBartonShowcaseWeb.HiringManagerTourHooks do
  @moduledoc false
  import Phoenix.LiveView
  import Phoenix.Component

  alias CadenBartonShowcaseWeb.HiringManagerTourContent
  alias CadenBartonShowcaseWeb.HiringManagerTourState

  def on_mount(:public, _params, _session, socket) do
    socket =
      socket
      |> assign_new(:tour_steps, fn -> HiringManagerTourContent.steps() end)
      |> assign_new(:tour_state, fn -> HiringManagerTourState.new() end)
      |> attach_hook(:tour_handle_event, :handle_event, &handle_event/3)

    {:cont, socket}
  end

  defp handle_event("tour_start", _params, socket) do
    {:halt,
     assign_and_save(
       socket,
       HiringManagerTourState.start(socket.assigns.tour_state, socket.assigns.tour_steps)
     )}
  end

  defp handle_event("tour_skip", _params, socket) do
    {:halt,
     assign_and_save(
       socket,
       HiringManagerTourState.skip(socket.assigns.tour_state, socket.assigns.tour_steps)
     )}
  end

  defp handle_event("tour_exit", _params, socket) do
    {:halt, assign_and_save(socket, HiringManagerTourState.exit())}
  end

  defp handle_event("tour_state_loaded", %{"state" => state}, socket) when is_map(state) do
    sanitized = HiringManagerTourState.sanitize_loaded(state, socket.assigns.tour_steps)
    {:halt, assign_and_save(socket, sanitized)}
  end

  defp handle_event("tour_action_completed", _params, socket) do
    {:halt,
     assign_and_save(
       socket,
       HiringManagerTourState.complete(socket.assigns.tour_state, socket.assigns.tour_steps)
     )}
  end

  defp handle_event(
         "tour_theme_changed",
         %{"theme" => "light"},
         %{assigns: %{tour_state: %{current_step_id: "light_mode"}}} = socket
       ) do
    {:halt,
     assign_and_save(
       socket,
       HiringManagerTourState.complete(socket.assigns.tour_state, socket.assigns.tour_steps)
     )}
  end

  defp handle_event("tour_theme_changed", _params, socket), do: {:cont, socket}

  defp handle_event(_event, _params, socket), do: {:cont, socket}

  defp assign_and_save(socket, state) do
    socket
    |> assign(:tour_state, state)
    |> push_event("tour_state_save", %{state: payload(state)})
  end

  defp payload(state) do
    %{
      active?: state.active?,
      current_step_id: state.current_step_id,
      completed_step_ids: MapSet.to_list(state.completed_step_ids),
      skipped_step_ids: MapSet.to_list(state.skipped_step_ids)
    }
  end
end
