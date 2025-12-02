defmodule CadenBartonShowcaseWeb.BuildsLive do
  use CadenBartonShowcaseWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, projects: projects())}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <section class="space-y-8 text-zinc-50">
        <div class="space-y-3">
          <p class="text-sm uppercase tracking-[0.2em] text-emerald-200">Portfolio</p>
          <h1 class="text-4xl font-bold leading-tight">Recent builds</h1>
          <p class="text-zinc-200">Phoenix and LiveView work that pairs resilient backends with usable frontends.</p>
        </div>

        <div class="space-y-6">
          <article
            :for={project <- @projects}
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
                <span><span class="font-semibold text-zinc-50">Problem:</span> {project.problem}</span>
              </li>
              <li class="flex gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                <span><span class="font-semibold text-zinc-50">Outcome:</span> {project.outcome}</span>
              </li>
            </ul>
          </article>
        </div>
      </section>
    </Layouts.app>
    """
  end

  defp projects do
    [
      %{
        slug: "realtime-ops-console",
        name: "Real-time Ops Console",
        summary: "LiveView console for fleet health with streaming telemetry and guardrails.",
        role: "Technical lead across Phoenix, LiveView UX, and rollout safety.",
        problem: "Oncall teams lacked a unified view of deploy state, incidents, and service health.",
        outcome: "Reduced mean time to respond by 35% with actionable alerts and drill-downs."
      },
      %{
        slug: "event-pipeline",
        name: "Event Pipeline & Analytics",
        summary: "Redpanda + ClickHouse pipeline ingesting billions of events per day.",
        role: "Architected ingestion, schemas, and back-pressure controls; built observability.",
        problem: "Legacy pipeline dropped events under burst load and lacked cost controls.",
        outcome: "Handles bursty traffic without loss; analytics queries 10x faster and cheaper."
      },
      %{
        slug: "multitenant-api",
        name: "Multi-tenant API Platform",
        summary: "Phoenix contexts with strict tenancy and reversible migrations.",
        role: "Led API design, tenancy enforcement, and feature-flagged releases.",
        problem: "Shared data models risked cross-tenant leakage and painful deploys.",
        outcome: "Zero tenant leaks post-migration and boring deploys with reversible changes."
      }
    ]
  end
end
