defmodule CadenBartonShowcaseWeb.HomeLive do
  use CadenBartonShowcaseWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <section class="relative overflow-hidden bg-gradient-to-b from-zinc-900/80 via-zinc-900 to-black text-zinc-50">
      <div class="absolute inset-0 opacity-60 blur-3xl">
        <div class="absolute h-72 w-72 -left-16 top-10 rounded-full bg-indigo-600/30"></div>
        <div class="absolute h-80 w-80 right-10 -bottom-10 rounded-full bg-amber-500/20"></div>
      </div>

      <div class="relative mx-auto flex max-w-6xl flex-col gap-16 px-6 py-16 lg:flex-row lg:items-start lg:py-24">
        <div class="flex-1 space-y-6">
          <p class="inline-flex items-center gap-2 rounded-full bg-zinc-800/70 px-3 py-1 text-sm font-medium text-zinc-100 ring-1 ring-zinc-700/60 backdrop-blur transition hover:-translate-y-0.5 hover:ring-zinc-500/60">
            <span class="h-2 w-2 rounded-full bg-emerald-400 animate-pulse"></span>
            Elixir &amp; Phoenix engineer focused on shipping resilient systems
          </p>
          <h1 class="text-4xl font-bold leading-tight sm:text-5xl">
            I design reliable backends, thoughtful frontends, and codebases that age well.
          </h1>
          <p class="text-lg text-zinc-200">
            I build production systems with Phoenix, LiveView, Redpanda, ClickHouse, and Postgres. My work centers on clarity,
            observability, and reducing maintenance drag.
          </p>
          <div class="flex flex-wrap gap-3">
            <.link
              navigate={~p"/how-i-work"}
              class="group inline-flex items-center gap-2 rounded-lg bg-emerald-500 px-5 py-3 text-sm font-semibold text-black shadow-lg shadow-emerald-500/30 transition hover:-translate-y-0.5 hover:bg-emerald-400"
            >
              See how I work
              <span class="transition-transform group-hover:translate-x-1">→</span>
            </.link>
            <.link
              navigate={~p"/builds"}
              class="inline-flex items-center gap-2 rounded-lg border border-zinc-600 px-5 py-3 text-sm font-semibold text-zinc-100 transition hover:-translate-y-0.5 hover:border-emerald-400 hover:text-emerald-200"
            >
              Recent builds
            </.link>
          </div>
        </div>

        <div class="w-full max-w-xl space-y-4 rounded-2xl border border-zinc-800 bg-zinc-900/80 p-6 shadow-xl shadow-black/30 backdrop-blur">
          <div class="flex items-center justify-between">
            <h2 class="text-xl font-semibold text-emerald-200">Engineering signals</h2>
            <span class="rounded-full bg-zinc-800 px-3 py-1 text-xs text-zinc-300">Built for longevity</span>
          </div>
          <div class="grid gap-4 sm:grid-cols-2">
            <article class="rounded-xl border border-zinc-800 bg-zinc-950/60 p-4 transition hover:-translate-y-1 hover:border-emerald-400/60">
              <p class="text-sm font-semibold text-emerald-200">Code quality</p>
              <p class="text-sm text-zinc-200">Domain-driven modules, crisp boundaries, and guardrails in pipelines and contexts.</p>
            </article>
            <article class="rounded-xl border border-zinc-800 bg-zinc-950/60 p-4 transition hover:-translate-y-1 hover:border-emerald-400/60">
              <p class="text-sm font-semibold text-emerald-200">Technical debt prevention</p>
              <p class="text-sm text-zinc-200">Readable patterns, instrumentation first, and migrations that keep rollbacks safe.</p>
            </article>
            <article class="rounded-xl border border-zinc-800 bg-zinc-950/60 p-4 transition hover:-translate-y-1 hover:border-emerald-400/60">
              <p class="text-sm font-semibold text-emerald-200">Testing discipline</p>
              <p class="text-sm text-zinc-200">Unit, LiveView, and property-style tests tied to behaviors and observability hooks.</p>
            </article>
            <article class="rounded-xl border border-zinc-800 bg-zinc-950/60 p-4 transition hover:-translate-y-1 hover:border-emerald-400/60">
              <p class="text-sm font-semibold text-emerald-200">AI-assisted workflow</p>
              <p class="text-sm text-zinc-200">ChatGPT for ideation, CODEX for flow, CodeRabbit reviews on GitHub to keep rigor high.</p>
            </article>
          </div>
        </div>
      </div>

      <div class="relative mx-auto max-w-6xl px-6 pb-20">
        <div class="grid gap-10 lg:grid-cols-3">
          <div class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">Projects</p>
            <h3 class="mt-3 text-xl font-semibold">Production systems I’ve shipped</h3>
            <ul class="mt-4 space-y-3 text-sm text-zinc-200">
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                Real-time analytics with Redpanda &amp; ClickHouse (billions of events/day).
              </li>
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                LiveView operational console with streaming updates and guardrails.
              </li>
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                Multi-tenant Postgres APIs with strict tenancy and rollout safety.
              </li>
            </ul>
          </div>

          <div class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">How I keep code clean</p>
            <h3 class="mt-3 text-xl font-semibold">Principles that prevent debt</h3>
            <ul class="mt-4 space-y-3 text-sm text-zinc-200">
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                Clear ownership: contexts as seams, boundary modules, zero “god modules.”
              </li>
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                Observability-first: telemetry events, structured logs, budgeted latencies.
              </li>
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                Change safety: feature flags, reversible migrations, and backfills with circuit breakers.
              </li>
            </ul>
          </div>

          <div class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">Testing &amp; AI</p>
            <h3 class="mt-3 text-xl font-semibold">Proof over promise</h3>
            <ul class="mt-4 space-y-3 text-sm text-zinc-200">
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                Unit and LiveView tests around behaviors, not implementation details.
              </li>
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                CI gates with coverage on critical paths; lazy HTML selectors to keep tests resilient.
              </li>
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                AI stack: ChatGPT for ideas, CODEX for shipping flow, CodeRabbit for PR rigor on GitHub.
              </li>
            </ul>
          </div>
        </div>
      </div>
    </section>
    """
  end
end
