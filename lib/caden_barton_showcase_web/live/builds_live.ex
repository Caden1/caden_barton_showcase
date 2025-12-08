defmodule CadenBartonShowcaseWeb.BuildsLive do
  use CadenBartonShowcaseWeb, :live_view

  alias CadenBartonShowcaseWeb.BuildsContent

  def mount(_params, _session, socket) do
    {:ok, assign(socket, projects: BuildsContent.projects())}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <section class="space-y-8 text-zinc-50">
        <div class="space-y-3">
          <p class="text-sm uppercase tracking-[0.2em] text-emerald-200">Portfolio</p>
          <h1 id="builds-heading" class="text-4xl font-bold leading-tight">Recent builds</h1>
          <p class="text-zinc-200">
            Phoenix and LiveView work that pairs resilient backends with usable frontends.
          </p>
        </div>

        <div id="builds-list" class="space-y-6">
          <article
            :for={project <- @projects}
            data-role="build-card"
            class="rounded-2xl border border-zinc-800 bg-zinc-950/80 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1 hover:border-emerald-400/60"
          >
            <div class="flex flex-wrap items-start justify-between gap-3">
              <div class="space-y-1">
                <h2 class="text-2xl font-semibold">{project.name}</h2>
                <p class="text-sm text-zinc-300">{project.summary}</p>
              </div>
              <.link
                navigate={~p"/builds/#{project.slug}"}
                class="inline-flex items-center gap-2 rounded-lg border border-emerald-400/40 px-4 py-2 text-sm font-semibold text-emerald-100 transition hover:-translate-y-0.5 hover:border-emerald-300 hover:text-emerald-50"
              >
                Read more →
              </.link>
            </div>
            <ul class="mt-4 space-y-2 text-sm text-zinc-200">
              <li class="flex gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                <span><span class="font-semibold text-zinc-50">Role:</span> {project.role}</span>
              </li>
              <li class="flex gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                <span>
                  <span class="font-semibold text-zinc-50">Problem:</span> {project.problem}
                </span>
              </li>
              <li class="flex gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                <span>
                  <span class="font-semibold text-zinc-50">Outcome:</span> {project.outcome}
                </span>
              </li>
            </ul>
          </article>
        </div>
      </section>
    </Layouts.app>
    """
  end
end
