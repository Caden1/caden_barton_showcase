defmodule CadenBartonShowcaseWeb.HowIWorkLive do
  use CadenBartonShowcaseWeb, :live_view

  import CadenBartonShowcaseWeb.HowIWorkComponent

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} tour_state={@tour_state} tour_steps={@tour_steps}>
      <div class="flex items-center justify-between pb-6">
        <div>
          <p class="text-xs uppercase tracking-[0.2em] text-emerald-200">Workflow</p>
          <h1 class="font-display text-3xl font-bold text-zinc-50">How I work</h1>
        </div>
        <.link
          navigate={~p"/"}
          class="inline-flex items-center gap-2 rounded-lg border border-emerald-400/60 px-4 py-2 text-sm font-semibold text-emerald-100 transition hover:-translate-y-0.5 hover:border-emerald-300"
        >
          Back to Home
        </.link>
      </div>

      <.how_i_work />
    </Layouts.app>
    """
  end
end
