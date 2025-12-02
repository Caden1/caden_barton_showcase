defmodule CadenBartonShowcaseWeb.HowIWorkLive do
  use CadenBartonShowcaseWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <section class="space-y-8 text-zinc-50">
        <div class="relative overflow-hidden rounded-3xl border border-zinc-800/70 bg-gradient-to-br from-zinc-900/90 via-zinc-950 to-black p-8 shadow-2xl shadow-black/40">
          <div class="pointer-events-none absolute inset-0 opacity-60 blur-3xl">
            <div class="absolute -left-12 top-4 h-48 w-48 rounded-full bg-emerald-500/20"></div>
            <div class="absolute -right-10 bottom-0 h-56 w-56 rounded-full bg-amber-500/15"></div>
          </div>

          <div class="relative space-y-4">
            <p class="inline-flex items-center gap-2 rounded-full bg-zinc-800/70 px-3 py-1 text-xs font-semibold uppercase tracking-[0.2em] text-emerald-100 ring-1 ring-zinc-700/60 backdrop-blur">
              Steady delivery · Reliable systems
            </p>
            <div class="space-y-3">
              <h1 class="text-4xl font-bold leading-tight">How I work</h1>
              <p class="text-lg text-zinc-200">
                I ship resilient backends, thoughtful frontends, and maintainable codebases with Phoenix and LiveView.
              </p>
            </div>
            <div class="flex flex-wrap gap-2 text-sm text-emerald-200">
              <span class="rounded-full border border-emerald-400/40 bg-emerald-500/10 px-3 py-1">Resilient backends</span>
              <span class="rounded-full border border-emerald-400/40 bg-emerald-500/10 px-3 py-1">Thoughtful frontends</span>
              <span class="rounded-full border border-emerald-400/40 bg-emerald-500/10 px-3 py-1">Maintainable codebases</span>
            </div>
          </div>
        </div>

        <div class="grid gap-6 md:grid-cols-2">
          <section class="rounded-2xl border border-zinc-800 bg-zinc-950/80 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1 hover:border-emerald-400/50">
            <div class="flex items-center justify-between">
              <h2 class="text-xl font-semibold text-emerald-200">Principles</h2>
              <span class="rounded-full border border-zinc-700/70 bg-zinc-900 px-3 py-1 text-xs text-zinc-300">Guardrails first</span>
            </div>
            <ul class="mt-4 space-y-3 text-sm text-zinc-200">
              <li class="flex gap-3">
                <span class="mt-2 h-2 w-2 rounded-full bg-emerald-400"></span>
                <div>
                  <p class="font-semibold text-zinc-50">Ownership</p>
                  <p class="text-zinc-300">End-to-end accountability, shepherding features from discovery to production stability.</p>
                </div>
              </li>
              <li class="flex gap-3">
                <span class="mt-2 h-2 w-2 rounded-full bg-emerald-400"></span>
                <div>
                  <p class="font-semibold text-zinc-50">Clear boundaries</p>
                  <p class="text-zinc-300">Contexts, boundary modules, and contracts that keep coupling low and intent readable.</p>
                </div>
              </li>
              <li class="flex gap-3">
                <span class="mt-2 h-2 w-2 rounded-full bg-emerald-400"></span>
                <div>
                  <p class="font-semibold text-zinc-50">Observability-first</p>
                  <p class="text-zinc-300">Telemetry, structured logs, and budgets for latency so issues surface before users feel them.</p>
                </div>
              </li>
              <li class="flex gap-3">
                <span class="mt-2 h-2 w-2 rounded-full bg-emerald-400"></span>
                <div>
                  <p class="font-semibold text-zinc-50">Change safety</p>
                  <p class="text-zinc-300">Feature flags, reversible migrations, and rollout plans that keep deploys boring.</p>
                </div>
              </li>
            </ul>
          </section>

          <section class="rounded-2xl border border-zinc-800 bg-zinc-950/80 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1 hover:border-emerald-400/50">
            <div class="flex items-center justify-between">
              <h2 class="text-xl font-semibold text-emerald-200">Engagement</h2>
              <span class="rounded-full border border-zinc-700/70 bg-zinc-900 px-3 py-1 text-xs text-zinc-300">Shipping rhythm</span>
            </div>
            <div class="mt-4 space-y-3 text-sm text-zinc-200">
              <p>Work moves in tight iterations with visible artifacts early—design notes, small PRs, and guardrail tests alongside code.</p>
              <p>I keep feedback loops short with structured PR reviews, pairing when needed, and demoable increments that keep stakeholders in the loop.</p>
              <p>Tests arrive with features, covering behaviors and LiveView flows so rollouts stay predictable.</p>
            </div>
          </section>
        </div>

        <section class="rounded-2xl border border-zinc-800 bg-zinc-950/80 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1 hover:border-emerald-400/50">
          <div class="flex items-center justify-between">
            <h2 class="text-xl font-semibold text-emerald-200">Tooling</h2>
            <span class="rounded-full border border-zinc-700/70 bg-zinc-900 px-3 py-1 text-xs text-zinc-300">Built for speed &amp; signal</span>
          </div>
          <div class="mt-4 grid gap-3 sm:grid-cols-2">
            <div class="rounded-xl border border-zinc-800/80 bg-zinc-900/80 p-4">
              <p class="text-sm font-semibold text-zinc-50">Application layer</p>
              <p class="mt-2 text-sm text-zinc-200">Phoenix &amp; LiveView for fast, real-time UX without frontend sprawl.</p>
            </div>
            <div class="rounded-xl border border-zinc-800/80 bg-zinc-900/80 p-4">
              <p class="text-sm font-semibold text-zinc-50">Data &amp; streaming</p>
              <p class="mt-2 text-sm text-zinc-200">Redpanda + ClickHouse for event streams and analytics, Postgres for trusted state.</p>
            </div>
            <div class="rounded-xl border border-zinc-800/80 bg-zinc-900/80 p-4 sm:col-span-2">
              <p class="text-sm font-semibold text-zinc-50">AI-assisted workflow</p>
              <p class="mt-2 text-sm text-zinc-200">ChatGPT for ideation, CODEX for flow, and PR bots to keep reviews sharp without losing human judgment.</p>
            </div>
          </div>
        </section>
      </section>
    </Layouts.app>
    """
  end
end
