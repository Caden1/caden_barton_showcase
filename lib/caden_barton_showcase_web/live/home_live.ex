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
            ELIXIR &amp; PHOENIX · AI-ASSISTED DELIVERY
          </p>
          <p class="mb-3 text-xs font-semibold tracking-[0.25em] text-emerald-400 uppercase">Caden Barton</p>
          <h1 class="font-display text-4xl font-bold leading-tight sm:text-5xl lg:text-6xl">
            I conduct <span class="bg-gradient-to-r from-emerald-400 via-cyan-400 to-fuchsia-500 bg-clip-text text-transparent">AI-powered</span> engineering teams that ship resilient systems.
          </h1>
          <p class="text-lg text-zinc-200">
            I build production systems with Elixir, Phoenix, LiveView, Redpanda, ClickHouse, and Postgres. I orchestrate ChatGPT,
            CODEX, and CodeRabbit as an AI team—while I own architecture, testing, and shipping—to keep codebases clear,
            observable, and low-maintenance.
          </p>
          <div class="flex flex-wrap gap-3">
            <.link
              navigate={~p"/#ai-conductor-workflow"}
              class="group inline-flex items-center gap-2 rounded-lg bg-gradient-to-r from-emerald-500 via-cyan-500 to-fuchsia-500 px-5 py-3 text-sm font-semibold text-slate-950 shadow-lg shadow-emerald-500/30 transition hover:-translate-y-0.5 hover:from-emerald-400 hover:via-cyan-400 hover:to-fuchsia-400 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-cyan-300"
            >
              See AI conductor workflow
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

        <div class="w-full max-w-xl bg-gradient-to-tr from-emerald-500 via-cyan-500 to-fuchsia-500 p-[1px] rounded-3xl">
          <div class="space-y-4 rounded-3xl border border-zinc-800 bg-zinc-900/80 p-6 shadow-xl shadow-black/30 backdrop-blur">
            <div class="flex items-center justify-between">
              <h2 class="text-xl font-semibold text-emerald-200">Engineering signals</h2>
              <span class="rounded-full bg-zinc-800 px-3 py-1 text-xs text-zinc-300">Built for longevity</span>
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
                <p class="text-xs uppercase tracking-[0.2em] text-emerald-400">ELIXIR &amp; PHOENIX ENGINEER · AI CONDUCTOR</p>
                <p class="text-xs text-slate-400">Shipping resilient products with observability, telemetry, and AI-assisted delivery.</p>
              </div>
            </div>
            <div class="grid gap-4 sm:grid-cols-2">
              <article class="rounded-xl border border-zinc-800 bg-zinc-950/60 p-4 transition hover:-translate-y-1 hover:border-emerald-400/60">
                <p class="text-sm font-semibold text-emerald-200">AI team orchestration</p>
                <p class="text-sm text-zinc-200">ChatGPT as PM, CODEX as pair engineer, CodeRabbit as reviewer. I break work into small branches and prompts so each agent stays focused and hallucinations stay low.</p>
              </article>
              <article class="rounded-xl border border-zinc-800 bg-zinc-950/60 p-4 transition hover:-translate-y-1 hover:border-emerald-400/60">
                <p class="text-sm font-semibold text-emerald-200">Production-grade Elixir systems</p>
                <p class="text-sm text-zinc-200">Phoenix &amp; LiveView backends on Redpanda, ClickHouse, and multi-tenant Postgres, designed for clarity, predictable latency, and safe rollbacks.</p>
              </article>
              <article class="rounded-xl border border-zinc-800 bg-zinc-950/60 p-4 transition hover:-translate-y-1 hover:border-emerald-400/60">
                <p class="text-sm font-semibold text-emerald-200">Testing &amp; CI you can trust</p>
                <p class="text-sm text-zinc-200">Unit, LiveView, and property-style tests owned by me—not AI—plus GitHub Actions that run <code class="text-xs">mix test</code> on every PR.</p>
              </article>
              <article class="rounded-xl border border-zinc-800 bg-zinc-950/60 p-4 transition hover:-translate-y-1 hover:border-emerald-400/60">
                <p class="text-sm font-semibold text-emerald-200">Technical debt prevention</p>
                <p class="text-sm text-zinc-200">Domain-driven contexts, explicit boundaries, and migrations planned with guardrails so future changes stay boring and safe.</p>
              </article>
            </div>
          </div>
        </div>
      </div>

      <section id="ai-team" class="relative mx-auto max-w-6xl px-6 pb-16">
        <div class="space-y-4">
          <h2 class="font-display text-3xl font-bold sm:text-4xl text-zinc-50">My AI team on this project</h2>
          <p class="text-zinc-200">
            I treat AI tools as collaborators, not replacements. For this site, I assembled a small AI team:
          </p>
        </div>
        <div class="mt-8 grid gap-6 sm:grid-cols-2">
          <article class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
            <div class="flex items-center gap-2 text-xs uppercase tracking-[0.2em] text-emerald-300">
              <span class="h-2 w-2 rounded-full bg-emerald-400"></span>
              ChatGPT
            </div>
            <h3 class="mt-3 text-xl font-semibold text-zinc-50">Project manager &amp; staff engineer</h3>
            <p class="mt-3 text-sm text-zinc-200">Researches and explores options, helps me gather requirements, and breaks work into small, testable branches and prompts.</p>
          </article>
          <article class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
            <div class="flex items-center gap-2 text-xs uppercase tracking-[0.2em] text-emerald-300">
              <span class="h-2 w-2 rounded-full bg-emerald-400"></span>
              CODEX
            </div>
            <h3 class="mt-3 text-xl font-semibold text-zinc-50">Implementation engineer</h3>
            <p class="mt-3 text-sm text-zinc-200">Implements features from structured prompts. Writes the first draft of code while I keep architecture, edge cases, and tests in mind.</p>
          </article>
          <article class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
            <div class="flex items-center gap-2 text-xs uppercase tracking-[0.2em] text-emerald-300">
              <span class="h-2 w-2 rounded-full bg-emerald-400"></span>
              CodeRabbit
            </div>
            <h3 class="mt-3 text-xl font-semibold text-zinc-50">Code reviewer</h3>
            <p class="mt-3 text-sm text-zinc-200">Reviews my pull requests, surfaces risks and refactors, and generates follow-up prompts I can feed back into ChatGPT and CODEX.</p>
          </article>
          <article class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
            <div class="flex items-center gap-2 text-xs uppercase tracking-[0.2em] text-emerald-300">
              <span class="h-2 w-2 rounded-full bg-emerald-400"></span>
              Me
            </div>
            <h3 class="mt-3 text-xl font-semibold text-zinc-50">The conductor</h3>
            <p class="mt-3 text-sm text-zinc-200">I keep the architecture cohesive, write and own tests, manage CI/CD, and decide when to accept or override AI suggestions.</p>
          </article>
        </div>
      </section>

      <section id="ai-conductor-workflow" class="relative mx-auto max-w-6xl px-6 pb-20">
        <div class="space-y-3">
          <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">WORKFLOW</p>
          <h2 class="font-display text-3xl font-bold sm:text-4xl text-zinc-50">AI conductor workflow</h2>
          <p class="text-zinc-200">
            How I built this site by orchestrating ChatGPT, CODEX, and CodeRabbit on small, safe branches.
          </p>
        </div>

        <ol class="mt-8 space-y-4">
          <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
            <div class="flex gap-3">
              <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">1</span>
              <div class="space-y-1">
                <p class="text-sm font-semibold text-emerald-200">Research &amp; requirements with ChatGPT</p>
                <p class="text-sm text-zinc-200">I explore options, gather context, and refine the requirements into a clear, scoped task.</p>
              </div>
            </div>
          </li>
          <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
            <div class="flex gap-3">
              <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">2</span>
              <div class="space-y-1">
                <p class="text-sm font-semibold text-emerald-200">Turn the requirements into a CODEX prompt</p>
                <p class="text-sm text-zinc-200">ChatGPT helps me phrase the prompt so CODEX can focus on one change at a time.</p>
              </div>
            </div>
          </li>
          <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
            <div class="flex gap-3">
              <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">3</span>
              <div class="space-y-1">
                <p class="text-sm font-semibold text-emerald-200">Create a small Git branch for the task</p>
                <p class="text-sm text-zinc-200">e.g., <code class="text-xs">feature/home-hero-ai-conductor</code>.</p>
              </div>
            </div>
          </li>
          <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
            <div class="flex gap-3">
              <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">4</span>
              <div class="space-y-1">
                <p class="text-sm font-semibold text-emerald-200">Feed the prompt to CODEX and implement</p>
                <p class="text-sm text-zinc-200">I review the diff and run the app locally to make sure behavior matches expectations.</p>
              </div>
            </div>
          </li>
          <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
            <div class="flex gap-3">
              <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">5</span>
              <div class="space-y-1">
                <p class="text-sm font-semibold text-emerald-200">Open a pull request</p>
                <p class="text-sm text-zinc-200">Every branch goes through a PR, even for small changes.</p>
              </div>
            </div>
          </li>
          <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
            <div class="flex gap-3">
              <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">6</span>
              <div class="space-y-1">
                <p class="text-sm font-semibold text-emerald-200">Let CodeRabbit review the PR</p>
                <p class="text-sm text-zinc-200">I talk to it like a human reviewer about tradeoffs, naming, and edge cases.</p>
              </div>
            </div>
          </li>
          <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
            <div class="flex gap-3">
              <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">7</span>
              <div class="space-y-1">
                <p class="text-sm font-semibold text-emerald-200">Use CodeRabbit’s “Prompt for AI Agents” output</p>
                <p class="text-sm text-zinc-200">I paste that into ChatGPT to refine, then into CODEX to apply follow-up changes.</p>
              </div>
            </div>
          </li>
          <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
            <div class="flex gap-3">
              <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">8</span>
              <div class="space-y-1">
                <p class="text-sm font-semibold text-emerald-200">Once everything looks good, squash &amp; merge</p>
                <p class="text-sm text-zinc-200">I delete the feature branch on GitHub to keep the repo clean.</p>
              </div>
            </div>
          </li>
          <li class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-4 shadow-lg shadow-black/30">
            <div class="flex gap-3">
              <span class="mt-1 flex h-8 w-8 items-center justify-center rounded-full border border-cyan-400/40 bg-emerald-500/10 text-sm font-semibold text-cyan-300">9</span>
              <div class="space-y-1">
                <p class="text-sm font-semibold text-emerald-200">Deploy and verify in higher environments</p>
                <p class="text-sm text-zinc-200">I keep AI away from production knobs and rely on observability to watch the system.</p>
              </div>
            </div>
          </li>
        </ol>

        <p class="mt-6 text-sm text-zinc-300">
          AI tools hallucinate less when the work is broken into small, well-scoped pieces. I use ChatGPT to slice the work,
          CODEX to implement, and CodeRabbit to review—while I stay responsible for tests, deploys, and system health.
        </p>
      </section>

      <section id="ai-case-study" class="relative mx-auto max-w-6xl px-6 pb-16">
        <div class="space-y-3">
          <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">CASE STUDY</p>
          <h2 class="font-display text-3xl font-bold sm:text-4xl text-zinc-50">This site, built with an AI team</h2>
          <p class="text-zinc-200">
            This portfolio is a live example of how I combine Elixir, Phoenix, and AI tools into a safe, repeatable workflow.
          </p>
        </div>

        <div class="mt-8 grid gap-6 sm:grid-cols-2">
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
                <a href="https://github.com/Caden1/caden_barton_showcase/pull/7" class="text-emerald-300 underline underline-offset-4">
                  https://github.com/Caden1/caden_barton_showcase/pull/7
                </a>
              </li>
            </ul>
          </article>
          <article class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
            <h3 class="font-display text-xl font-semibold text-zinc-50">CI, tests, and AI limits</h3>
            <ul class="mt-4 space-y-2 text-sm text-zinc-200">
              <li class="flex gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                GitHub Actions runs <code class="text-xs">mix test</code> on every PR create/update so broken changes can’t be merged.
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

      <div class="relative mx-auto max-w-6xl px-6 pb-20">
        <div class="grid gap-10 lg:grid-cols-3">
          <div class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
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
          </div>

          <div class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
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
          </div>

          <div class="rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-xl shadow-black/30 transition hover:-translate-y-1">
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">TESTING &amp; AI</p>
            <h3 class="mt-3 text-xl font-semibold font-display">Proof over promise</h3>
            <ul class="mt-4 space-y-3 text-sm text-zinc-200">
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                Unit, LiveView, and property-style tests around behaviors, not implementation details.
              </li>
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                GitHub Actions CI gate that runs <code class="text-xs">mix test</code> on every PR and blocks merges on failures.
              </li>
              <li class="flex items-start gap-2">
                <span class="mt-1 h-2 w-2 rounded-full bg-emerald-400"></span>
                AI tools help with implementation, but I write and review the tests myself and use CodeRabbit as a second pair of eyes.
              </li>
            </ul>
          </div>
        </div>
      </div>
    </section>
    """
  end
end
