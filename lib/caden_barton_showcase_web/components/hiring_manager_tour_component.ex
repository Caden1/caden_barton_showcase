defmodule CadenBartonShowcaseWeb.HiringManagerTourComponent do
  @moduledoc false
  use CadenBartonShowcaseWeb, :html

  attr :tour_state, :map, required: true
  attr :tour_steps, :list, required: true

  def current_step_panel(assigns) do
    assigns =
      assigns
      |> assign(
        :current_step,
        Enum.find(assigns.tour_steps, &(&1.id == assigns.tour_state.current_step_id))
      )
      |> assign(:cta, fn step_id -> cta_for(step_id) end)
      |> assign(:instruction, fn step_id -> instruction_for(step_id) end)

    ~H"""
    <%= if @tour_state.active? && @current_step do %>
      <div class="border-b border-emerald-900/50 bg-emerald-950/70">
        <div class="mx-auto flex max-w-6xl flex-col gap-4 px-4 py-4 sm:px-6 lg:px-8">
          <div class="flex items-center justify-between">
            <div>
              <p class="text-[11px] uppercase tracking-[0.2em] text-emerald-300">Current step</p>
              <h3 class="text-lg font-semibold text-emerald-100">{@current_step.label}</h3>
              <p class="text-sm text-emerald-100/80">{@instruction.(@current_step.id)}</p>
            </div>
            <div class="flex items-center gap-2">
              <button
                type="button"
                class="rounded-lg border border-emerald-500/60 px-3 py-1.5 text-xs font-semibold text-emerald-100 transition hover:-translate-y-0.5 hover:border-emerald-300"
                phx-click="tour_skip"
              >
                Skip
              </button>
            </div>
          </div>

          {render_cta(@current_step.id, @cta.(@current_step.id))}
        </div>
      </div>
    <% end %>
    """
  end

  defp render_cta("start", %{label: label}) do
    assigns = %{label: label}

    ~H"""
    <div class="flex items-center gap-2">
      <button
        type="button"
        class="rounded-lg bg-emerald-500 px-4 py-2 text-sm font-semibold text-emerald-950 shadow hover:bg-emerald-400 transition"
        phx-click={JS.push("tour_action_completed", value: %{step_id: "start"})}
      >
        {@label}
      </button>
    </div>
    """
  end

  defp render_cta("light_mode", %{label: label}) do
    assigns = %{label: label}

    ~H"""
    <div class="flex items-center gap-2">
      <button
        type="button"
        class="rounded-lg bg-amber-400 px-4 py-2 text-sm font-semibold text-amber-950 shadow hover:bg-amber-300 transition"
        phx-click={JS.dispatch("phx:set-theme", to: "button[data-phx-theme='light']")}
      >
        {@label}
      </button>
      <p class="text-xs text-amber-100/80">Use the header toggle to switch to light mode.</p>
    </div>
    """
  end

  defp render_cta("how_i_work", %{label: label}) do
    assigns = %{label: label}

    ~H"""
    <div class="flex items-center gap-2">
      <button
        type="button"
        class="rounded-lg bg-emerald-500 px-4 py-2 text-sm font-semibold text-emerald-950 shadow hover:bg-emerald-400 transition"
        phx-click={
          JS.add_class("ring-2 ring-amber-400 animate-pulse", to: "#principles-section")
          |> JS.push("tour_action_completed", value: %{step_id: "how_i_work"})
        }
      >
        {@label}
      </button>
      <p class="text-xs text-emerald-100/80">Highlighting principles section.</p>
    </div>
    """
  end

  defp render_cta("ai_loop", %{label: label, checklist: checklist}) do
    assigns = %{label: label, checklist: checklist}

    ~H"""
    <div class="flex items-center gap-2">
      <button
        id="tour-ai-loop-copy"
        type="button"
        class="rounded-lg bg-cyan-400 px-4 py-2 text-sm font-semibold text-cyan-950 shadow hover:bg-cyan-300 transition"
        phx-hook="TourChecklistCopy"
        data-step-id="ai_loop"
        data-checklist={@checklist}
      >
        {@label}
      </button>
      <p class="text-xs text-cyan-100/80">Copies the PR safety checklist to your clipboard.</p>
    </div>
    """
  end

  defp render_cta("case_study", %{label: label}) do
    assigns = %{label: label}

    ~H"""
    <div class="flex items-center gap-2">
      <button
        type="button"
        class="rounded-lg bg-fuchsia-400 px-4 py-2 text-sm font-semibold text-fuchsia-950 shadow hover:bg-fuchsia-300 transition"
        phx-click={
          JS.remove_class("hidden", to: "#tour-decision-log")
          |> JS.push("tour_action_completed", value: %{step_id: "case_study"})
        }
      >
        {@label}
      </button>
      <p class="text-xs text-fuchsia-100/80">Reveals the decision log below.</p>
    </div>
    """
  end

  defp render_cta("builds", %{label: label, target: target}) do
    assigns = %{label: label, target: to_string(target)}

    ~H"""
    <div class="flex items-center gap-2">
      <button
        type="button"
        class="rounded-lg bg-emerald-500 px-4 py-2 text-sm font-semibold text-emerald-950 shadow hover:bg-emerald-400 transition"
        phx-click={
          JS.push("tour_action_completed", value: %{step_id: "builds"})
          |> JS.navigate(@target)
        }
      >
        {@label}
      </button>
      <p class="text-xs text-emerald-100/80">Opens the featured build.</p>
    </div>
    """
  end

  defp render_cta(_step_id, _assigns) do
    assigns = %{}
    ~H""
  end

  defp cta_for("start"), do: %{label: "Start tour"}
  defp cta_for("light_mode"), do: %{label: "Switch to Light mode"}

  defp cta_for("how_i_work"), do: %{label: "Highlight delivery principles"}

  defp cta_for("ai_loop"),
    do: %{
      label: "Copy PR-safety checklist",
      checklist: """
      mix test
      - Ensure telemetry emits on failure paths
      - Verify feature flags guard risky changes
      - Confirm rollback plan is documented
      """
    }

  defp cta_for("case_study"), do: %{label: "Reveal decision log"}

  defp cta_for("builds"),
    do: %{label: "Open featured build", target: "/builds/realtime-ops-console"}

  defp cta_for(_), do: %{label: "Continue"}

  defp instruction_for("start"), do: "Kick off the guided tour."
  defp instruction_for("light_mode"), do: "Toggle Light mode in the header."
  defp instruction_for("how_i_work"), do: "Draw attention to the delivery principles."
  defp instruction_for("ai_loop"), do: "Copy the PR checklist you can paste into reviews."
  defp instruction_for("case_study"), do: "Reveal the decision log section."
  defp instruction_for("builds"), do: "Open the featured build to finish the tour."
  defp instruction_for(_), do: "Follow the guided path."
end
