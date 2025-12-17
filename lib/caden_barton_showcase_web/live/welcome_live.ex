defmodule CadenBartonShowcaseWeb.WelcomeLive do
  use CadenBartonShowcaseWeb, :live_view

  @greeting "I'm Caden. I ship resilient Elixir systems with clear guardrails, telemetry, and a tight AI-assisted workflow you can trust."

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
                  I'll keep this concise and show you how I deliver safely, fast, and with full accountability.
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
                    do: "Let's dive into how I deliver.",
                    else: "Want to skip? I'll jump to the tour."
                  )}
                </p>
              </div>
            </div>
          </div>

          <div class="w-full max-w-xl space-y-4">
            <div class="rounded-3xl border border-zinc-800 bg-zinc-900/70 p-6 shadow-xl shadow-black/30">
              <p class="text-xs uppercase tracking-[0.3em] text-emerald-200">Orientation</p>
              <p class="mt-2 text-2xl font-semibold text-white">Ready to see how I deliver?</p>
              <p class="mt-2 text-sm text-zinc-200">
                Start with the guided tour for hiring managers or jump straight to recent builds.
              </p>

              <div class="mt-6 flex flex-col gap-3">
                <.link
                  id="cta-hiring-manager-tour"
                  navigate={~p"/hiring-manager"}
                  class="inline-flex items-center justify-center gap-2 rounded-xl bg-emerald-500 px-4 py-3 text-sm font-semibold text-emerald-950 shadow-lg shadow-emerald-500/30 transition hover:-translate-y-0.5 hover:bg-emerald-400"
                >
                  Start Hiring Manager Guided Tour <span>→</span>
                </.link>
                <.link
                  id="cta-browse-builds"
                  navigate={~p"/builds"}
                  class="inline-flex items-center justify-center gap-2 rounded-xl border border-zinc-700 px-4 py-3 text-sm font-semibold text-zinc-100 transition hover:-translate-y-0.5 hover:border-emerald-300"
                >
                  Browse builds
                </.link>
              </div>
            </div>
          </div>
        </div>
      </section>
    </Layouts.app>
    """
  end
end
