defmodule CadenBartonShowcaseWeb.HomeLive do
  use CadenBartonShowcaseWeb, :live_view

  import CadenBartonShowcaseWeb.PersonaSelectorComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} tour_state={@tour_state} tour_steps={@tour_steps} full_bleed>
      <section
        class="relative overflow-hidden bg-gradient-to-b from-zinc-900/80 via-zinc-900 to-black text-zinc-50"
        id="home-page"
      >
        <div class="absolute inset-0 opacity-60 blur-3xl">
          <div class="absolute h-72 w-72 -left-16 top-10 rounded-full bg-indigo-600/30"></div>
          <div class="absolute h-80 w-80 right-10 -bottom-10 rounded-full bg-amber-500/20"></div>
        </div>

        <div class="relative mx-auto flex max-w-5xl flex-col items-center gap-12 px-6 py-16 text-center lg:py-24">
          <div class="w-full max-w-3xl space-y-6">
            <p class="mx-auto inline-flex items-center gap-2 rounded-full bg-zinc-800/70 px-3 py-1 text-sm font-medium text-zinc-100 ring-1 ring-zinc-700/60 backdrop-blur transition hover:-translate-y-0.5 hover:ring-zinc-500/60">
              <span class="h-2 w-2 rounded-full bg-emerald-400 animate-pulse"></span>
              ELIXIR &amp; PHOENIX · AI-ASSISTED DELIVERY
            </p>
            <p class="mb-3 text-xs font-semibold tracking-[0.25em] text-emerald-400 uppercase">
              Caden Barton
            </p>
            <h1 class="font-display text-4xl font-bold leading-tight sm:text-5xl lg:text-6xl">
              I ship resilient <span class="kw-highlight">Elixir</span>
              systems with an AI-assisted workflow I trust.
            </h1>
            <p class="text-lg text-zinc-200">
              I build production systems on <span class="kw-highlight">Elixir</span>, <span class="kw-highlight">Phoenix</span>, <span class="kw-highlight">LiveView</span>, Redpanda, ClickHouse, and Postgres. I use ChatGPT, CODEX, and CodeRabbit as a small AI crew - while I stay in charge of design, tests, and deployments - so the code stays understandable, <span class="kw-highlight">observable</span>, and easy to change. Think of me as an AI workflow conductor for your codebase.
            </p>
            <div class="flex flex-wrap items-center justify-center gap-3">
              <.link
                id="cta-hiring-managers"
                navigate={~p"/hiring-manager"}
                class="btn-game group inline-flex items-center gap-2 rounded-lg bg-gradient-to-r from-emerald-500 via-cyan-500 to-fuchsia-500 px-5 py-3 text-sm font-semibold text-slate-950 shadow-lg shadow-emerald-500/30 transition hover:-translate-y-0.5 hover:from-emerald-400 hover:via-cyan-400 hover:to-fuchsia-400 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-cyan-300"
              >
                See what you get if you hire me
                <span class="transition-transform group-hover:translate-x-1">→</span>
              </.link>
              <.link
                id="cta-ai-conductor-workflow"
                navigate={~p"/how-i-work"}
                class="btn-game group inline-flex items-center gap-2 rounded-lg border border-zinc-600 px-5 py-3 text-sm font-semibold text-zinc-100 transition hover:-translate-y-0.5 hover:border-emerald-400 hover:text-emerald-200"
              >
                See my AI-assisted workflow
                <span class="transition-transform group-hover:translate-x-1">→</span>
              </.link>
              <.link
                id="cta-builds"
                navigate={~p"/builds"}
                class="btn-game inline-flex items-center gap-2 rounded-lg border border-zinc-600 px-5 py-3 text-sm font-semibold text-zinc-100 transition hover:-translate-y-0.5 hover:border-emerald-400 hover:text-emerald-200"
              >
                Recent builds
              </.link>
            </div>
          </div>

          <div class="w-full max-w-xl mx-auto text-left bg-gradient-to-tr from-emerald-500 via-cyan-500 to-fuchsia-500 p-[1px] rounded-3xl">
            <div class="space-y-4 rounded-3xl border border-zinc-800 bg-zinc-900/80 p-6 shadow-xl shadow-black/30 backdrop-blur">
              <div class="flex items-center justify-between">
                <h2 class="text-xl font-semibold text-emerald-200">Engineering signals</h2>
                <span class="rounded-full bg-zinc-800 px-3 py-1 text-xs text-zinc-300">
                  Built for longevity
                </span>
              </div>
              <div class="flex items-center gap-4 rounded-3xl border border-slate-800 bg-slate-900/70 p-5">
                <div class="h-16 w-16 rounded-2xl overflow-hidden border border-emerald-500/40 shadow-lg shadow-emerald-500/20">
                  <img
                    src={~p"/images/caden-barton.jpeg"}
                    alt="Portrait of Caden Barton"
                    class="h-full w-full object-cover"
                  />
                </div>
                <div class="space-y-1">
                  <p class="text-sm font-semibold text-slate-50">Caden Barton</p>
                  <p class="text-xs uppercase tracking-[0.2em] text-emerald-400">
                    ELIXIR &amp; PHOENIX ENGINEER · AI-ASSISTED DELIVERY
                  </p>
                  <p class="text-xs text-slate-400">
                    Shipping resilient products with observability, telemetry, and AI-assisted delivery.
                  </p>
                </div>
              </div>
              <div class="grid gap-4 sm:grid-cols-2">
                <article class="rounded-xl border border-zinc-800 bg-zinc-950/60 p-4 transition hover:-translate-y-1 hover:border-emerald-400/60">
                  <p class="text-sm font-semibold text-emerald-200">AI team orchestration</p>
                  <p class="text-sm text-zinc-200">
                    ChatGPT as PM, CODEX as pair engineer, CodeRabbit as reviewer. I slice work into small branches so each tool has one narrow job and I stay accountable for the result.
                  </p>
                </article>
                <article class="rounded-xl border border-zinc-800 bg-zinc-950/60 p-4 transition hover:-translate-y-1 hover:border-emerald-400/60">
                  <p class="text-sm font-semibold text-emerald-200">
                    Production-grade Elixir systems
                  </p>
                  <p class="text-sm text-zinc-200">
                    <span class="kw-highlight">Phoenix</span>
                    + <span class="kw-highlight">LiveView</span>
                    backends on Redpanda, ClickHouse, and multi-tenant Postgres, designed for clear <span class="kw-highlight">observability</span>, predictable latency, and <span class="kw-highlight">safe rollbacks</span>.
                  </p>
                </article>
                <article class="rounded-xl border border-zinc-800 bg-zinc-950/60 p-4 transition hover:-translate-y-1 hover:border-emerald-400/60">
                  <p class="text-sm font-semibold text-emerald-200">
                    <span class="kw-highlight">Testing</span>
                    &amp; <span class="kw-highlight">CI</span>
                    you can trust
                  </p>
                  <p class="text-sm text-zinc-200">
                    Unit, <span class="kw-highlight">LiveView</span>, and property-style tests I write and maintain myself, plus GitHub Actions that run mix test on every PR and block merges on failures.
                  </p>
                </article>
                <article class="rounded-xl border border-zinc-800 bg-zinc-950/60 p-4 transition hover:-translate-y-1 hover:border-emerald-400/60">
                  <p class="text-sm font-semibold text-emerald-200">Technical debt prevention</p>
                  <p class="text-sm text-zinc-200">
                    Domain-driven contexts, explicit boundaries, and migrations planned with guardrails so future changes stay boring instead of risky with <span class="kw-highlight">safe rollbacks</span>.
                  </p>
                </article>
              </div>
            </div>
          </div>
        </div>

        <.persona_selector id="start-here-selector" />
      </section>
    </Layouts.app>
    """
  end
end
