defmodule CadenBartonShowcaseWeb.CaseStudyLive do
  use CadenBartonShowcaseWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} tour_state={@tour_state} tour_steps={@tour_steps}>
      <div class="space-y-6">
        <div class="flex items-center justify-between">
          <div class="space-y-2">
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">Case study</p>
            <h1 class="font-display text-3xl font-bold sm:text-4xl text-zinc-50">
              This site, built with an AI team
            </h1>
            <p class="text-zinc-200">
              This portfolio runs on Elixir, Phoenix, and LiveView with Redpanda, ClickHouse, and Postgres - showing how I use an AI-assisted workflow to ship production systems.
            </p>
          </div>
          <.link
            navigate={~p"/"}
            class="inline-flex items-center gap-2 rounded-lg border border-emerald-400/60 px-4 py-2 text-sm font-semibold text-emerald-100 transition hover:-translate-y-0.5 hover:border-emerald-300"
          >
            Back to Home
          </.link>
        </div>

        <div class="mt-8 grid gap-6 sm:grid-cols-2">
          <article class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">Projects</p>
            <h3 class="mt-3 text-xl font-semibold font-display">Production systems I've shipped</h3>
            <ul class="mt-4 space-y-3 text-sm text-zinc-200">
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                Real-time analytics pipelines on Redpanda &amp; ClickHouse, ingesting billions of telemetry events per day.
              </li>
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                LiveView operational consoles with streaming updates, backpressure-aware subscriptions, and guardrails for operators.
              </li>
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                Multi-tenant Postgres APIs with strict tenancy, reversible migrations, and safe rollout patterns.
              </li>
            </ul>
          </article>

          <div
            id="tour-decision-log"
            class="hidden rounded-2xl border border-fuchsia-400/40 bg-fuchsia-900/20 p-6 shadow-xl shadow-fuchsia-500/20"
          >
            <p class="text-xs uppercase tracking-[0.2em] text-fuchsia-200">Decision log</p>
            <h3 class="mt-2 text-lg font-semibold text-fuchsia-100">Key delivery calls</h3>
            <ul class="mt-3 space-y-2 text-sm text-fuchsia-100/90">
              <li>
                Picked LiveView to keep UI + state consistent without heavy frontend dependencies.
              </li>
              <li>Invested in telemetry upfront so AI-assisted changes stay observable.</li>
              <li>Kept migrations reversible and behind flags to protect deploys.</li>
            </ul>
          </div>

          <article class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">Testing &amp; AI</p>
            <h3 class="mt-3 text-xl font-semibold font-display">Proof over promise</h3>
            <ul class="mt-4 space-y-3 text-sm text-zinc-200">
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                Unit, LiveView, and property-style tests around behaviors, not implementation details.
              </li>
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                GitHub Actions CI gate that runs <code class="text-xs">mix test</code>
                on every PR and blocks merges on failures.
              </li>
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                AI tools help with implementation, but I write and review the tests myself and use CodeRabbit as a second pair of eyes.
              </li>
            </ul>
          </article>

          <article class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">How I keep code clean</p>
            <h3 class="mt-3 text-xl font-semibold font-display">Principles that prevent debt</h3>
            <ul class="mt-4 space-y-3 text-sm text-zinc-200">
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                Clear ownership: contexts as seams, no "god modules".
              </li>
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                Observability-first: telemetry events, structured logs, and budgeted latencies for critical paths.
              </li>
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                Change safety: feature flags, reversible migrations, and backfills with circuit breakers.
              </li>
            </ul>
          </article>

          <article class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
            <h3 class="font-display text-xl font-semibold text-zinc-50">CodeRabbit in the loop</h3>
            <ul class="mt-4 space-y-2 text-sm text-zinc-200">
              <li class="flex gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                Every pull request runs through CodeRabbit for review.
              </li>
              <li class="flex gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                I have conversations with it just like I would with a human engineer.
              </li>
              <li class="flex gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                Example review implemented here:
                <a
                  href="https://github.com/Caden1/caden_barton_showcase/pull/7"
                  class="text-emerald-300 underline underline-offset-4"
                >
                  https://github.com/Caden1/caden_barton_showcase/pull/7
                </a>
              </li>
            </ul>
          </article>

          <article class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
            <h3 class="font-display text-xl font-semibold text-zinc-50">
              CI, tests, and AI limits
            </h3>
            <ul class="mt-4 space-y-2 text-sm text-zinc-200">
              <li class="flex gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                GitHub Actions runs <code class="text-xs">mix test</code>
                on every PR create/update so broken changes cannot be merged.
              </li>
              <li class="flex gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                AI tools are bad at understanding test intent, so I write and own my unit and LiveView tests.
              </li>
              <li class="flex gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                At the bottom of each CodeRabbit review, I use the "Prompt for AI Agents" output as input to ChatGPT and CODEX to safely apply its suggestions.
              </li>
            </ul>
          </article>
        </div>
      </div>
    </Layouts.app>
    """
  end
end
