defmodule CadenBartonShowcaseWeb.BuildsIndexLive do
  use CadenBartonShowcaseWeb, :live_view

  alias CadenBartonShowcaseWeb.BuildsContent
  import CadenBartonShowcaseWeb.BuildsIndexComponent

  def mount(_params, _session, socket) do
    {:ok, assign(socket, builds: BuildsContent.builds())}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} quest_state={@quest_state} quests={@quests}>
      <div class="flex items-center justify-between pb-6">
        <div>
          <p class="text-xs uppercase tracking-[0.2em] text-emerald-200">Portfolio</p>
          <h1 class="font-display text-3xl font-bold text-zinc-50">Recent builds</h1>
        </div>
        <.link
          navigate={~p"/"}
          class="inline-flex items-center gap-2 rounded-lg border border-emerald-400/60 px-4 py-2 text-sm font-semibold text-emerald-100 transition hover:-translate-y-0.5 hover:border-emerald-300"
        >
          Back to Home
        </.link>
      </div>

      <.builds_index builds={@builds} />
    </Layouts.app>
    """
  end
end
