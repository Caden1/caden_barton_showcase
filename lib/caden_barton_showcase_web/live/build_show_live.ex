defmodule CadenBartonShowcaseWeb.BuildShowLive do
  use CadenBartonShowcaseWeb, :live_view

  alias CadenBartonShowcaseWeb.BuildsContent

  def mount(_params, _session, socket) do
    {:ok, assign(socket, project: nil)}
  end

  def handle_params(%{"slug" => slug}, _uri, socket) do
    {:noreply, assign(socket, project: BuildsContent.get_project(slug), slug: slug)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <%= if @project do %>
        <section class="space-y-8 text-zinc-50">
          <div class="space-y-3">
            <p class="text-sm uppercase tracking-[0.2em] text-emerald-200">Build detail</p>
            <h1 id="build-heading" class="text-4xl font-bold leading-tight">{@project.name}</h1>
            <p class="text-zinc-200">{@project.summary}</p>
          </div>

          <div class="grid gap-6 lg:grid-cols-3">
            <article
              id="build-context-section"
              class="rounded-2xl border border-zinc-800 bg-zinc-950/80 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1 hover:border-emerald-400/60"
            >
              <h2 class="text-lg font-semibold text-emerald-200">Context / Problem</h2>
              <p class="mt-3 text-sm text-zinc-200">{@project.problem}</p>
              <p class="mt-4 text-xs uppercase tracking-[0.16em] text-zinc-400">Role</p>
              <p class="text-sm text-zinc-200">{@project.role}</p>
            </article>

            <article
              id="build-approach-section"
              class="rounded-2xl border border-zinc-800 bg-zinc-950/80 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1 hover:border-emerald-400/60"
            >
              <h2 class="text-lg font-semibold text-emerald-200">Approach / Architecture</h2>
              <p class="mt-3 text-sm text-zinc-200">{@project.approach}</p>
            </article>

            <article
              id="build-outcome-section"
              class="rounded-2xl border border-zinc-800 bg-zinc-950/80 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1 hover:border-emerald-400/60"
            >
              <h2 class="text-lg font-semibold text-emerald-200">Outcome / Impact</h2>
              <p class="mt-3 text-sm text-zinc-200">{@project.outcome}</p>
              <a
                id="builds-back-link"
                href={~p"/builds"}
                class="mt-4 inline-flex items-center gap-2 text-sm font-semibold text-emerald-200 transition hover:translate-x-1"
              >
                Back to builds
              </a>
            </article>
          </div>
        </section>
      <% else %>
        <section id="build-not-found" class="space-y-4 text-zinc-50">
          <h1 class="text-3xl font-bold">Project not found</h1>
          <p class="text-zinc-300">We couldn’t find that build. Check the link and try again.</p>
          <a
            id="builds-back-link"
            href={~p"/builds"}
            class="inline-flex items-center gap-2 rounded-lg border border-emerald-400/40 px-4 py-2 text-sm font-semibold text-emerald-100 transition hover:-translate-y-0.5 hover:border-emerald-300 hover:text-emerald-50"
          >
            Back to builds
          </a>
        </section>
      <% end %>
    </Layouts.app>
    """
  end
end
