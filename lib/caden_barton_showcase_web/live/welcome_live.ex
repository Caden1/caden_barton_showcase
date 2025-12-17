defmodule CadenBartonShowcaseWeb.WelcomeLive do
  use CadenBartonShowcaseWeb, :live_view

  alias Phoenix.LiveView.JS

  @greeting "Hey, I'm Caden. I build calm, resilient Elixir systems with an AI crew that ships on schedule."

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, intro_done: false, greeting: @greeting)}
  end

  @impl true
  def handle_event("welcome_typed", _params, socket) do
    {:noreply, assign(socket, :intro_done, true)}
  end

  def handle_event("skip_intro", _params, socket) do
    {:noreply, assign(socket, :intro_done, true)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} tour_state={@tour_state} tour_steps={@tour_steps} full_bleed>
      <section class="relative isolate min-h-screen overflow-hidden bg-gradient-to-b from-slate-950 via-zinc-950 to-black text-zinc-50">
        <div class="absolute inset-0">
          <div class="absolute -left-24 top-10 h-72 w-72 rounded-full bg-emerald-500/20 blur-3xl">
          </div>
          <div class="absolute right-10 top-40 h-60 w-60 rounded-full bg-cyan-500/20 blur-3xl"></div>
          <div class="absolute -bottom-32 right-24 h-96 w-96 rounded-full bg-fuchsia-500/20 blur-3xl">
          </div>
        </div>

        <div class="relative mx-auto flex max-w-6xl flex-col gap-12 px-6 py-20 lg:flex-row lg:items-center lg:justify-between lg:py-28">
          <div class="flex-1 space-y-8">
            <div class="inline-flex items-center gap-2 rounded-full bg-emerald-500/10 px-3 py-1 text-xs font-semibold uppercase tracking-[0.2em] text-emerald-200 ring-1 ring-emerald-400/30 backdrop-blur">
              <span class="h-2 w-2 rounded-full bg-emerald-400 animate-pulse"></span> Introduction
            </div>
            <div class="space-y-4 rounded-3xl border border-emerald-500/30 bg-zinc-900/60 p-8 shadow-[0_25px_120px_-40px_rgba(16,185,129,0.45)] backdrop-blur-lg">
              <p class="text-sm font-semibold text-emerald-200">Welcome</p>
              <div class="space-y-3">
                <%= if @intro_done do %>
                  <p
                    id="welcome-typewriter"
                    aria-live="polite"
                    class="font-display text-3xl font-semibold leading-tight text-white sm:text-4xl"
                  >
                    {@greeting}
                  </p>
                <% else %>
                  <p
                    id="welcome-typewriter"
                    aria-live="polite"
                    phx-hook="Typewriter"
                    data-text={@greeting}
                    class="font-display text-3xl font-semibold leading-tight text-white sm:text-4xl"
                  >
                  </p>
                <% end %>
                <p class="text-lg text-emerald-100/80">
                  I'll keep it brief and tailored, then point you at the most relevant pieces of my work.
                </p>
              </div>
              <div class="flex flex-wrap items-center gap-4">
                <button
                  id="skip-intro"
                  type="button"
                  phx-click="skip_intro"
                  class="inline-flex items-center gap-2 rounded-full border border-emerald-400/50 px-4 py-2 text-sm font-semibold text-emerald-100 transition hover:-translate-y-0.5 hover:border-emerald-300 hover:text-white focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-emerald-400"
                >
                  <.icon name="hero-forward" class="h-4 w-4" /> Skip intro
                </button>
                <p class="text-sm text-emerald-100/70">
                  {if(@intro_done,
                    do: "Thanks for letting me dive right in.",
                    else: "I'll type this out like I speak - feel free to jump ahead."
                  )}
                </p>
              </div>
            </div>
          </div>

          <div class="w-full max-w-xl space-y-4">
            <div class="rounded-3xl border border-zinc-800 bg-zinc-900/70 p-6 shadow-xl shadow-black/30">
              <p class="text-xs uppercase tracking-[0.3em] text-emerald-200">Orientation</p>
              <p class="mt-2 text-2xl font-semibold text-white">What brings you here?</p>
              <p class="mt-2 text-sm text-zinc-200">
                Pick the vibe that matches your visit and I'll jump you to the sections that fit.
              </p>

              <%= if @intro_done do %>
                <div class="mt-6 grid gap-4 md:grid-cols-2">
                  <button
                    id="persona-hiring-manager"
                    type="button"
                    phx-click={persona_action(~p"/hiring-manager")}
                    class="btn-game group flex flex-col items-start gap-3 rounded-2xl border border-emerald-500/50 bg-emerald-500/10 p-4 text-left transition hover:-translate-y-1 hover:border-emerald-300 hover:bg-emerald-400/15"
                  >
                    <span class="inline-flex items-center gap-2 rounded-full bg-emerald-500/15 px-3 py-1 text-xs font-semibold text-emerald-100">
                      <.icon name="hero-briefcase" class="h-4 w-4" /> Hiring Manager
                    </span>
                    <p class="text-sm text-emerald-50">
                      See delivery signals, decision-making, and proof I'm reliable under pressure.
                    </p>
                    <span class="text-xs font-semibold text-emerald-200 opacity-80 transition group-hover:translate-x-1">
                      View the signals →
                    </span>
                  </button>

                  <button
                    id="persona-developer"
                    type="button"
                    phx-click={persona_action(~p"/how-i-work")}
                    class="btn-game group flex flex-col items-start gap-3 rounded-2xl border border-cyan-400/40 bg-cyan-500/10 p-4 text-left transition hover:-translate-y-1 hover:border-cyan-200 hover:bg-cyan-400/15"
                  >
                    <span class="inline-flex items-center gap-2 rounded-full bg-cyan-400/15 px-3 py-1 text-xs font-semibold text-cyan-100">
                      <.icon name="hero-code-bracket" class="h-4 w-4" /> Developer
                    </span>
                    <p class="text-sm text-cyan-50">
                      Jump to the systems, patterns, and AI-assisted workflows powering my builds.
                    </p>
                    <span class="text-xs font-semibold text-cyan-200 opacity-80 transition group-hover:translate-x-1">
                      Jump to workflow →
                    </span>
                  </button>

                  <button
                    id="persona-curious"
                    type="button"
                    phx-click={persona_action(~p"/projects")}
                    class="btn-game group flex flex-col items-start gap-3 rounded-2xl border border-fuchsia-400/50 bg-fuchsia-500/10 p-4 text-left transition hover:-translate-y-1 hover:border-fuchsia-200 hover:bg-fuchsia-400/15 md:col-span-2"
                  >
                    <span class="inline-flex items-center gap-2 rounded-full bg-fuchsia-400/15 px-3 py-1 text-xs font-semibold text-fuchsia-100">
                      <.icon name="hero-sparkles" class="h-4 w-4" /> Just Curious
                    </span>
                    <p class="text-sm text-fuchsia-50">
                      Take the scenic route with highlights from builds, process, and playful experiments.
                    </p>
                    <span class="text-xs font-semibold text-fuchsia-200 opacity-80 transition group-hover:translate-x-1">
                      Explore projects →
                    </span>
                  </button>
                </div>
              <% else %>
                <div class="mt-6 rounded-2xl border border-dashed border-zinc-700 bg-zinc-900/60 p-4 text-sm text-zinc-300">
                  Hang tight - typing the greeting now. You can always tap "Skip intro" to jump straight into the paths.
                </div>
              <% end %>
            </div>
          </div>
        </div>
      </section>
    </Layouts.app>
    """
  end

  defp persona_action(path) do
    JS.navigate(path)
  end
end
