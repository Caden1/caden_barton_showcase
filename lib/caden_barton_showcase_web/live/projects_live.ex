defmodule CadenBartonShowcaseWeb.ProjectsLive do
  use CadenBartonShowcaseWeb, :live_view

  alias CadenBartonShowcaseWeb.BuildsContent
  import CadenBartonShowcaseWeb.BuildsIndexComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, builds: BuildsContent.builds())}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="space-y-6">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-200">Projects</p>
            <h1 class="font-display text-3xl font-bold text-zinc-50">Selected projects</h1>
            <p class="text-zinc-200">A quick tour of systems and outcomes across my recent work.</p>
          </div>
          <.link
            navigate={~p"/"}
            class="inline-flex items-center gap-2 rounded-lg border border-emerald-400/60 px-4 py-2 text-sm font-semibold text-emerald-100 transition hover:-translate-y-0.5 hover:border-emerald-300"
          >
            Back to Home
          </.link>
        </div>

        <section id="section-projects">
          <.builds_index builds={@builds} />
        </section>
      </div>
    </Layouts.app>
    """
  end
end
