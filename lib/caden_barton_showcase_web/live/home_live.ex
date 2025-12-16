defmodule CadenBartonShowcaseWeb.HomeLive do
  use CadenBartonShowcaseWeb, :live_view

  alias CadenBartonShowcaseWeb.BuildsContent
  import CadenBartonShowcaseWeb.PersonaSelectorComponent
  import CadenBartonShowcaseWeb.HowIWorkComponent
  import CadenBartonShowcaseWeb.BuildsIndexComponent
  import CadenBartonShowcaseWeb.ProofUnlocksComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} quest_state={@quest_state} quests={@quests} full_bleed>
      <section
        class="relative overflow-hidden bg-gradient-to-b from-zinc-900/80 via-zinc-900 to-black text-zinc-50"
        id="home-page"
        phx-hook="ScrollToSection"
      >
        <div class="absolute inset-0 opacity-60 blur-3xl">
          <div class="absolute h-72 w-72 -left-16 top-10 rounded-full bg-indigo-600/30"></div>
          <div class="absolute h-80 w-80 right-10 -bottom-10 rounded-full bg-amber-500/20"></div>
        </div>
        <div
          id="quest-progress-observer"
          phx-hook="QuestProgressObserver"
          data-quest-targets={
            steps = get_in(@quests, [@quest_state && @quest_state.quest_id, :steps]) || []
            Enum.map_join(steps, ",", & &1.target_id)
          }
          class="hidden"
        >
        </div>

        <div class="relative mx-auto flex max-w-6xl flex-col gap-16 px-6 py-16 lg:flex-row lg:items-start lg:py-24">
          <div class="flex-1 space-y-6">
            <p class="inline-flex items-center gap-2 rounded-full bg-zinc-800/70 px-3 py-1 text-sm font-medium text-zinc-100 ring-1 ring-zinc-700/60 backdrop-blur transition hover:-translate-y-0.5 hover:ring-zinc-500/60">
              <span class="h-2 w-2 rounded-full bg-emerald-400 animate-pulse"></span>
              ELIXIR &amp; PHOENIX · AI-ASSISTED DELIVERY
            </p>
            <p class="mb-3 text-xs font-semibold tracking-[0.25em] text-emerald-400 uppercase">
              Caden Barton
            </p>
            <h1 class="font-display text-4xl font-bold leading-tight sm:text-5xl lg:text-6xl">
              I ship resilient Elixir systems with an AI-assisted workflow I trust.
            </h1>
            <p class="text-lg text-zinc-200">
              I build production systems on Elixir, Phoenix, LiveView, Redpanda, ClickHouse, and Postgres. I use ChatGPT, CODEX, and CodeRabbit as a small AI crew—while I stay in charge of design, tests, and deployments—so the code stays understandable, observable, and easy to change. Think of me as an AI workflow conductor for your codebase.
            </p>
            <div class="flex flex-wrap gap-3">
              <a
                id="cta-hiring-managers"
                href="#for-hiring-managers"
                phx-hook="ScrollToSectionLink"
                data-scroll-target="for-hiring-managers"
                class="group inline-flex items-center gap-2 rounded-lg bg-gradient-to-r from-emerald-500 via-cyan-500 to-fuchsia-500 px-5 py-3 text-sm font-semibold text-slate-950 shadow-lg shadow-emerald-500/30 transition hover:-translate-y-0.5 hover:from-emerald-400 hover:via-cyan-400 hover:to-fuchsia-400 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-cyan-300"
              >
                See what you get if you hire me
                <span class="transition-transform group-hover:translate-x-1">→</span>
              </a>
              <a
                id="cta-ai-conductor-workflow"
                href="#section-how-i-work"
                phx-hook="ScrollToSectionLink"
                data-scroll-target="section-how-i-work"
                class="group inline-flex items-center gap-2 rounded-lg border border-zinc-600 px-5 py-3 text-sm font-semibold text-zinc-100 transition hover:-translate-y-0.5 hover:border-emerald-400 hover:text-emerald-200"
              >
                See my AI-assisted workflow
                <span class="transition-transform group-hover:translate-x-1">→</span>
              </a>
              <a
                id="cta-builds"
                href="#section-builds"
                phx-hook="ScrollToSectionLink"
                data-scroll-target="section-builds"
                class="inline-flex items-center gap-2 rounded-lg border border-zinc-600 px-5 py-3 text-sm font-semibold text-zinc-100 transition hover:-translate-y-0.5 hover:border-emerald-400 hover:text-emerald-200"
              >
                Recent builds
              </a>
            </div>
          </div>

          <div class="w-full max-w-xl bg-gradient-to-tr from-emerald-500 via-cyan-500 to-fuchsia-500 p-[1px] rounded-3xl">
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
                    Phoenix + LiveView backends on Redpanda, ClickHouse, and multi-tenant Postgres, designed for clear observability, predictable latency, and safe rollbacks.
                  </p>
                </article>
                <article class="rounded-xl border border-zinc-800 bg-zinc-950/60 p-4 transition hover:-translate-y-1 hover:border-emerald-400/60">
                  <p class="text-sm font-semibold text-emerald-200">Testing &amp; CI you can trust</p>
                  <p class="text-sm text-zinc-200">
                    Unit, LiveView, and property-style tests I write and maintain myself, plus GitHub Actions that run mix test on every PR and block merges on failures.
                  </p>
                </article>
                <article class="rounded-xl border border-zinc-800 bg-zinc-950/60 p-4 transition hover:-translate-y-1 hover:border-emerald-400/60">
                  <p class="text-sm font-semibold text-emerald-200">Technical debt prevention</p>
                  <p class="text-sm text-zinc-200">
                    Domain-driven contexts, explicit boundaries, and migrations planned with guardrails so future changes stay boring instead of risky.
                  </p>
                </article>
              </div>
            </div>
          </div>
        </div>

        <.persona_selector id="start-here-selector" />

        <section id="quest-mode" class="relative mx-auto max-w-6xl px-6 pb-8">
          <div class="rounded-3xl border border-emerald-900/60 bg-emerald-900/10 p-6 shadow-lg shadow-emerald-800/20 backdrop-blur">
            <div class="flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
              <div class="space-y-1">
                <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">Quest Mode</p>
                <h2 class="text-2xl font-semibold text-emerald-100">Guided paths for each visitor</h2>
                <p class="text-sm text-emerald-100/80">
                  Pick a path and I’ll guide you through the sections that match what you’re looking for.
                </p>
              </div>
              <div class="flex flex-wrap gap-3">
                <button
                  id="quest-start-hiring-manager"
                  class="rounded-lg bg-emerald-500 px-4 py-2 text-sm font-semibold text-emerald-950 shadow hover:-translate-y-0.5 hover:bg-emerald-400 transition"
                  phx-click="quest_start"
                  phx-value-quest_id="hiring_manager"
                >
                  Hiring manager path
                </button>
                <button
                  id="quest-start-developer"
                  class="rounded-lg border border-emerald-500/60 px-4 py-2 text-sm font-semibold text-emerald-100 shadow hover:-translate-y-0.5 hover:border-emerald-400 transition"
                  phx-click="quest_start"
                  phx-value-quest_id="developer"
                >
                  Developer path
                </button>
                <button
                  id="quest-start-curious"
                  class="rounded-lg border border-emerald-500/60 px-4 py-2 text-sm font-semibold text-emerald-100 shadow hover:-translate-y-0.5 hover:border-emerald-400 transition"
                  phx-click="quest_start"
                  phx-value-quest_id="curious"
                >
                  Curious tour
                </button>
              </div>
            </div>

            <.proof_unlocks unlocked_ids={Map.get(@quest_state || %{}, :unlocked_ids, MapSet.new())} />
          </div>
        </section>

        <section id="section-how-i-work" class="relative mx-auto max-w-6xl px-6 pb-20">
          <.how_i_work />
        </section>

        <section id="section-ai-delivery-loop" class="relative mx-auto max-w-6xl px-6 pb-20">
          <div class="space-y-3">
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">WORKFLOW</p>
            <h2 class="font-display text-3xl font-bold sm:text-4xl text-zinc-50">
              How I work with an AI team
            </h2>
            <p class="text-zinc-200">
              I treat AI tools as collaborators, not decision-makers. Here’s who’s on the “team” and what they help with.
            </p>
          </div>

          <div class="mt-8 grid gap-6 sm:grid-cols-3">
            <article class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
              <div class="flex items-center gap-2 text-xs uppercase tracking-[0.2em] text-emerald-300">
                <span class="h-2 w-2 rounded-full bg-emerald-400"></span> ChatGPT
              </div>
              <h3 class="mt-3 text-xl font-semibold text-zinc-50">
                Project partner &amp; staff engineer
              </h3>
              <p class="mt-3 text-sm text-zinc-200">
                Helps me explore options, clarify requirements, and break features into small, testable branches and prompts. I stay responsible for the plan.
              </p>
            </article>
            <article class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
              <div class="flex items-center gap-2 text-xs uppercase tracking-[0.2em] text-emerald-300">
                <span class="h-2 w-2 rounded-full bg-emerald-400"></span> CODEX
              </div>
              <h3 class="mt-3 text-xl font-semibold text-zinc-50">Implementation engineer</h3>
              <p class="mt-3 text-sm text-zinc-200">
                Takes a focused prompt and writes the first pass of the code. I refactor it, wire it into the rest of the system, and make sure it matches the intent.
              </p>
            </article>
            <article class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
              <div class="flex items-center gap-2 text-xs uppercase tracking-[0.2em] text-emerald-300">
                <span class="h-2 w-2 rounded-full bg-emerald-400"></span> CodeRabbit
              </div>
              <h3 class="mt-3 text-xl font-semibold text-zinc-50">Code reviewer</h3>
              <p class="mt-3 text-sm text-zinc-200">
                Reviews my pull requests, flags risks and edge cases, and gives me follow-up prompts I can feed back into ChatGPT and CODEX.
              </p>
            </article>
          </div>

          <div class="mt-12 space-y-2">
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">Detailed workflow</p>
            <h3 class="text-lg font-semibold text-zinc-100">Step-by-step delivery loop</h3>
            <p class="text-sm text-zinc-300">
              The nine-step loop I use to keep AI contributions scoped, reviewed, and production-safe.
            </p>
          </div>

          <ol class="mt-6 space-y-4">
            <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
              <div class="flex gap-3">
                <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">
                  1
                </span>
                <div class="space-y-1">
                  <p class="text-sm font-semibold text-emerald-200">
                    Research &amp; requirements with ChatGPT
                  </p>
                  <p class="text-sm text-zinc-200">
                    I explore options and edge cases with ChatGPT, then turn the conversation into a clear, scoped task I can own.
                  </p>
                </div>
              </div>
            </li>
            <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
              <div class="flex gap-3">
                <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">
                  2
                </span>
                <div class="space-y-1">
                  <p class="text-sm font-semibold text-emerald-200">
                    Turn the requirements into a CODEX prompt
                  </p>
                  <p class="text-sm text-zinc-200">
                    I write a short prompt that calls out the goal, constraints, and tests so CODEX focuses on one change at a time.
                  </p>
                </div>
              </div>
            </li>
            <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
              <div class="flex gap-3">
                <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">
                  3
                </span>
                <div class="space-y-1">
                  <p class="text-sm font-semibold text-emerald-200">
                    Create a small Git branch for the task
                  </p>
                  <p class="text-sm text-zinc-200">
                    I work in feature branches (for example, feature/home-hero-and-signals-copy) so every change is easy to review and roll back.
                  </p>
                </div>
              </div>
            </li>
            <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
              <div class="flex gap-3">
                <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">
                  4
                </span>
                <div class="space-y-1">
                  <p class="text-sm font-semibold text-emerald-200">
                    Feed the prompt to CODEX and implement
                  </p>
                  <p class="text-sm text-zinc-200">
                    CODEX writes the first pass; I clean it up, run the app, and make sure the behavior matches the intent.
                  </p>
                </div>
              </div>
            </li>
            <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
              <div class="flex gap-3">
                <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">
                  5
                </span>
                <div class="space-y-1">
                  <p class="text-sm font-semibold text-emerald-200">Open a pull request</p>
                  <p class="text-sm text-zinc-200">
                    Every branch gets a PR, even tiny ones, so nothing sneaks into main without review.
                  </p>
                </div>
              </div>
            </li>
            <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
              <div class="flex gap-3">
                <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">
                  6
                </span>
                <div class="space-y-1">
                  <p class="text-sm font-semibold text-emerald-200">Let CodeRabbit review the PR</p>
                  <p class="text-sm text-zinc-200">
                    CodeRabbit gives me a second set of eyes on tradeoffs, naming, and edge cases.
                  </p>
                </div>
              </div>
            </li>
            <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
              <div class="flex gap-3">
                <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">
                  7
                </span>
                <div class="space-y-1">
                  <p class="text-sm font-semibold text-emerald-200">
                    Use CodeRabbit’s “Prompt for AI Agents” output
                  </p>
                  <p class="text-sm text-zinc-200">
                    I paste CodeRabbit’s “Prompt for AI Agents” output back into ChatGPT to refine, then into CODEX to apply safe follow-up changes.
                  </p>
                </div>
              </div>
            </li>
            <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
              <div class="flex gap-3">
                <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">
                  8
                </span>
                <div class="space-y-1">
                  <p class="text-sm font-semibold text-emerald-200">
                    Once everything looks good, squash &amp; merge
                  </p>
                  <p class="text-sm text-zinc-200">
                    Once everything looks good, I squash and merge to keep the history tidy and future debugging simple.
                  </p>
                </div>
              </div>
            </li>
            <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
              <div class="flex gap-3">
                <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">
                  9
                </span>
                <div class="space-y-1">
                  <p class="text-sm font-semibold text-emerald-200">
                    Deploy and verify in higher environments
                  </p>
                  <p class="text-sm text-zinc-200">
                    I keep AI away from production knobs and lean on observability to watch the system in higher environments.
                  </p>
                </div>
              </div>
            </li>
          </ol>

          <p class="mt-6 text-sm text-zinc-300">
            AI tools work best when the tasks are small and well-scoped. I use ChatGPT to slice the work,
            CODEX to draft changes, and CodeRabbit to review—while I stay responsible for tests, deploys, and system health.
          </p>
        </section>

        <section id="section-builds" class="relative mx-auto max-w-6xl px-6 pb-20">
          <.builds_index projects={BuildsContent.projects()} />
        </section>

        <section id="case-study" class="relative mx-auto max-w-6xl px-6 pb-16">
          <div class="space-y-3">
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">CASE STUDY</p>
            <h2 class="font-display text-3xl font-bold sm:text-4xl text-zinc-50">
              This site, built with an AI team
            </h2>
            <p class="text-zinc-200">
              This portfolio runs on Elixir, Phoenix, and LiveView with Redpanda, ClickHouse, and Postgres—showing how I use an AI-assisted workflow to ship production systems.
            </p>
          </div>

          <div class="mt-8 grid gap-6 sm:grid-cols-2">
            <article class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
              <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">PROJECTS</p>
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

            <article class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
              <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">TESTING &amp; AI</p>
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
              <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">HOW I KEEP CODE CLEAN</p>
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
                  on every PR create/update so broken changes can’t be merged.
                </li>
                <li class="flex gap-2">
                  <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                  AI tools are bad at understanding test intent, so I write and own my unit and LiveView tests.
                </li>
                <li class="flex gap-2">
                  <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                  At the bottom of each CodeRabbit review, I use the “Prompt for AI Agents” output as input to ChatGPT and CODEX to safely apply its suggestions.
                </li>
              </ul>
            </article>
          </div>
        </section>

        <section id="for-hiring-managers" class="relative mx-auto max-w-5xl px-6 pb-20">
          <div class="bg-gradient-to-tr from-emerald-500 via-cyan-500 to-fuchsia-500 p-[1px] rounded-3xl shadow-xl shadow-black/30">
            <div class="rounded-3xl border border-zinc-800 bg-zinc-950/80 p-8">
              <p class="text-xs uppercase tracking-[0.2em] text-emerald-200">FOR HIRING MANAGERS</p>
              <h2 class="mt-3 font-display text-3xl font-bold text-zinc-50">
                What you get if you hire me
              </h2>
              <p class="mt-3 text-zinc-200">
                I combine production-grade Elixir systems with an AI-assisted workflow that stays accountable and observable.
              </p>
              <ul class="mt-4 space-y-3 text-sm text-zinc-200">
                <li class="flex items-start gap-2">
                  <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                  Production Elixir/Phoenix systems with observability, telemetry, and safe migrations built in from day one.
                </li>
                <li class="flex items-start gap-2">
                  <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                  An engineer who can orchestrate AI tools (ChatGPT, CODEX, CodeRabbit) to move faster while still writing, owning, and reviewing the critical code paths.
                </li>
                <li class="flex items-start gap-2">
                  <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                  Small, well-scoped branches and PRs with documented AI prompts, so changes stay easy to review and roll back.
                </li>
                <li class="flex items-start gap-2">
                  <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                  CI that runs <code class="text-xs">mix test</code>
                  on every PR and blocks merges when tests fail.
                </li>
              </ul>
            </div>
          </div>
        </section>
      </section>
    </Layouts.app>
    """
  end
end
