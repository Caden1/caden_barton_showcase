defmodule CadenBartonShowcaseWeb.HiringManagerLive do
  use CadenBartonShowcaseWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="space-y-6">
        <div class="flex items-center justify-between">
          <div class="space-y-2">
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-200">For hiring managers</p>
            <h1 class="font-display text-3xl font-bold text-zinc-50">What you get if you hire me</h1>
            <p class="text-zinc-200">
              I combine production-grade Elixir systems with an AI-assisted workflow that stays accountable and observable.
            </p>
          </div>
          <.link
            navigate={~p"/"}
            class="inline-flex items-center gap-2 rounded-lg border border-emerald-400/60 px-4 py-2 text-sm font-semibold text-emerald-100 transition hover:-translate-y-0.5 hover:border-emerald-300"
          >
            Back to Home
          </.link>
        </div>

        <div class="bg-gradient-to-tr from-emerald-500 via-cyan-500 to-fuchsia-500 p-[1px] rounded-3xl shadow-xl shadow-black/30">
          <div class="rounded-3xl border border-zinc-800 bg-zinc-950/80 p-8">
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
      </div>
    </Layouts.app>
    """
  end
end
