defmodule CadenBartonShowcaseWeb.QuestOverlayComponent do
  @moduledoc false
  use CadenBartonShowcaseWeb, :html

  alias CadenBartonShowcaseWeb.QuestContent

  def quest_overlay(assigns) do
    assigns =
      assigns
      |> assign(:quest, Map.get(assigns.quests, assigns.quest_state.quest_id))
      |> assign(:completed_count, MapSet.size(assigns.quest_state.completed_step_ids))
      |> assign(:target_paths, QuestContent.target_paths())

    ~H"""
    <%= if @quest_state.active? && @quest do %>
      <div
        id="quest-overlay"
        class="fixed bottom-6 right-6 z-50 w-full max-w-sm rounded-3xl border border-emerald-900/60 bg-zinc-950/90 p-4 shadow-2xl shadow-emerald-900/30 backdrop-blur"
      >
        <div class="flex items-start justify-between gap-3">
          <div>
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">Quest active</p>
            <h3 class="text-lg font-semibold text-emerald-100">
              {@quest.title}
            </h3>
            <p class="text-sm text-emerald-200" id="quest-progress">
              {@completed_count}/{length(@quest.steps)} completed
            </p>
          </div>
          <div class="flex items-center gap-2">
            <button
              id="quest-reset"
              class="rounded-lg border border-emerald-500/60 px-3 py-1 text-xs font-semibold text-emerald-100 hover:border-emerald-400 transition"
              phx-click="quest_reset"
            >
              Reset
            </button>
            <button
              id="quest-close"
              class="rounded-lg bg-zinc-800 px-3 py-1 text-xs font-semibold text-zinc-200 hover:bg-zinc-700 transition"
              phx-click="quest_close"
            >
              Close
            </button>
          </div>
        </div>

        <div class="mt-4 space-y-2">
          <div class="text-xs font-semibold uppercase tracking-[0.18em] text-emerald-300">
            Steps
          </div>
          <div class="space-y-2">
            <div
              :for={step <- @quest.steps}
              id={"quest-step-#{step.id}"}
              class="flex items-center justify-between rounded-2xl border border-emerald-900/60 bg-emerald-900/10 px-3 py-2"
            >
              <div>
                <p class="text-sm font-semibold text-emerald-100">{step.label}</p>
                <div class="flex items-center gap-2 text-xs text-emerald-200/80">
                  <.link
                    id={"quest-step-link-#{step.id}"}
                    navigate={Map.get(@target_paths, step.target_id, "/")}
                    class="inline-flex items-center gap-1 text-emerald-300 underline underline-offset-4 hover:text-emerald-200"
                  >
                    Go
                  </.link>
                  <span>·</span>
                  <span>{step.target_id}</span>
                </div>
              </div>
              <button
                type="button"
                id={"quest-step-toggle-#{step.id}"}
                phx-click="quest_toggle_step"
                phx-value-step_id={step.id}
                class={[
                  "rounded-full border px-3 py-1 text-xs font-semibold transition",
                  MapSet.member?(@quest_state.completed_step_ids, step.id) &&
                    "border-emerald-400 bg-emerald-500/20 text-emerald-100",
                  !MapSet.member?(@quest_state.completed_step_ids, step.id) &&
                    "border-emerald-500/60 bg-zinc-900 text-emerald-100 hover:border-emerald-400"
                ]}
              >
                <%= if MapSet.member?(@quest_state.completed_step_ids, step.id) do %>
                  Done
                <% else %>
                  Mark done
                <% end %>
              </button>
            </div>
          </div>
        </div>
      </div>
    <% end %>

    <%= if !@quest_state.active? && @quest_state.quest_id && @quest do %>
      <button
        id="quest-open"
        type="button"
        phx-click="quest_open"
        class="btn-game group fixed bottom-6 right-6 z-50 inline-flex items-center gap-3 rounded-full border border-emerald-800/70 bg-zinc-950/90 px-4 py-3 text-sm font-semibold text-emerald-100 shadow-xl shadow-emerald-900/30 backdrop-blur transition hover:-translate-y-0.5 hover:border-emerald-500/70 hover:shadow-emerald-700/40"
      >
        <span class="flex items-center gap-2">
          Quest
          <span class="h-2 w-2 rounded-full bg-emerald-400 shadow-[0_0_12px_rgba(16,185,129,0.55)] group-hover:shadow-[0_0_16px_rgba(16,185,129,0.7)]">
          </span>
        </span>
        <span class="rounded-full bg-emerald-900/50 px-2 py-1 text-[11px] font-medium text-emerald-100/90">
          {@completed_count}/{length(@quest.steps)} steps
        </span>
      </button>
    <% end %>
    """
  end
end
