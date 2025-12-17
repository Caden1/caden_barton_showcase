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
      |> attach_hook(:tour_handle_params, :handle_params, &handle_params/3)
      |> attach_hook(:tour_handle_event, :handle_event, &handle_event/3)

    {:cont, socket}
  end

  defp handle_params(_params, uri, socket) do
    {:cont, assign(socket, :current_path, URI.parse(uri).path)}
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
    {:halt, assign_and_save(socket, sanitized, navigate?: false)}
  end

  defp handle_event("tour_action_completed", %{"step_id" => step_id}, socket) do
    if step_id == socket.assigns.tour_state.current_step_id do
      {:halt,
       assign_and_save(
         socket,
         HiringManagerTourState.complete(socket.assigns.tour_state, socket.assigns.tour_steps)
       )}
    else
      {:halt, socket}
    end
  end

  defp handle_event(
         "tour_theme_changed",
         %{"theme" => "light"},
         %{assigns: %{tour_state: %{current_step_id: "light_mode"}}} = socket
       ) do
    socket =
      socket
      |> put_flash(:info, "Light Mode Activated")
      |> assign_and_save(
        HiringManagerTourState.complete(socket.assigns.tour_state, socket.assigns.tour_steps)
      )

    {:halt, socket}
  end

  defp handle_event("tour_theme_changed", _params, socket), do: {:cont, socket}

  defp handle_event(_event, _params, socket), do: {:cont, socket}

  defp assign_and_save(socket, state, opts \\ []) do
    socket =
      socket
      |> assign(:tour_state, state)
      |> push_event("tour_state_save", %{state: payload(state)})

    if Keyword.get(opts, :navigate?, true) do
      maybe_navigate(socket, state)
    else
      socket
    end
  end

  defp payload(state) do
    %{
      active?: state.active?,
      current_step_id: state.current_step_id,
      completed_step_ids: MapSet.to_list(state.completed_step_ids),
      skipped_step_ids: MapSet.to_list(state.skipped_step_ids)
    }
  end

  defp maybe_navigate(%{assigns: %{current_path: current}} = socket, %{active?: true} = state) do
    case HiringManagerTourContent.path_for(state.current_step_id) do
      nil -> socket
      path when path == current -> socket
      path -> push_navigate(socket, to: path)
    end
  end

  defp maybe_navigate(socket, _state), do: socket
end
