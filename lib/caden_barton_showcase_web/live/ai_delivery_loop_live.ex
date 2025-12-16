defmodule CadenBartonShowcaseWeb.AiDeliveryLoopLive do
  use CadenBartonShowcaseWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} quest_state={@quest_state} quests={@quests}>
      <div class="space-y-6">
        <div class="flex items-center justify-between">
          <div class="space-y-2">
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">Workflow</p>
            <h1 class="font-display text-3xl font-bold sm:text-4xl text-zinc-50">
              How I work with an AI team
            </h1>
            <p class="text-zinc-200">
              I treat AI tools as collaborators, not decision-makers. Here's who is on the "team" and what they help with.
            </p>
          </div>
          <.link
            navigate={~p"/"}
            class="inline-flex items-center gap-2 rounded-lg border border-emerald-400/60 px-4 py-2 text-sm font-semibold text-emerald-100 transition hover:-translate-y-0.5 hover:border-emerald-300"
          >
            Back to Home
          </.link>
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
                <p class="text-sm font-semibold text-emerald-200">Slice the work</p>
                <p class="text-sm text-zinc-200">
                  I break the feature into small branches with explicit success criteria and rollbacks.
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
                <p class="text-sm font-semibold text-emerald-200">Prompt CODEX for first pass</p>
                <p class="text-sm text-zinc-200">
                  CODEX drafts the implementation inside a tight prompt. I review and edit it to match the design.
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
                <p class="text-sm font-semibold text-emerald-200">Wire it in with tests</p>
                <p class="text-sm text-zinc-200">
                  I integrate the code, add or refine tests, and ensure telemetry and rollout plans are in place.
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
                <p class="text-sm font-semibold text-emerald-200">Run CI and tighten the PR</p>
                <p class="text-sm text-zinc-200">
                  I push small branches, make the PR easy to review, and ensure CI is green before asking for review.
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
                <p class="text-sm font-semibold text-emerald-200">CodeRabbit review</p>
                <p class="text-sm text-zinc-200">
                  I ask CodeRabbit to critique the PR, then decide which suggestions to adopt and what to ignore.
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
                <p class="text-sm font-semibold text-emerald-200">Prompt-driven follow-ups</p>
                <p class="text-sm text-zinc-200">
                  I paste CodeRabbit's "Prompt for AI Agents" output back into ChatGPT to refine, then into CODEX to apply safe follow-up changes.
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
                  I squash and merge to keep the history tidy and simplify future debugging.
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
          CODEX to draft changes, and CodeRabbit to review - while I stay responsible for tests, deploys, and system health.
        </p>
      </div>
    </Layouts.app>
    """
  end
end
