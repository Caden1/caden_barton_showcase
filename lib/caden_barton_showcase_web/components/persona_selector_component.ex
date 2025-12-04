defmodule CadenBartonShowcaseWeb.PersonaSelectorComponent do
  use Phoenix.Component

  attr :id, :string, required: true
  attr :selected_persona, :string, default: "recruiter"
  attr :target, :any, default: nil

  def persona_selector(assigns) do
    ~H"""
    <section id={@id} class="relative mx-auto max-w-6xl px-6 pb-4">
      <div class="space-y-3">
        <h2 class="font-display text-3xl font-bold sm:text-4xl text-zinc-50">Start here</h2>
        <p class="text-zinc-200">Tell me who you are and I’ll show you what to read.</p>
      </div>

      <div class="mt-8 grid gap-4 sm:gap-6 md:grid-cols-3">
        <article
          phx-click="select_persona"
          phx-value-persona="recruiter"
          phx-target={@target}
          class={card_classes(@selected_persona == "recruiter")}
        >
          <p class="text-sm font-semibold text-emerald-200">I’m a hiring manager</p>
          <p class="mt-2 text-sm text-zinc-200">Get a quick overview of how I work and what I’ve shipped.</p>
        </article>
        <article
          phx-click="select_persona"
          phx-value-persona="developer"
          phx-target={@target}
          class={card_classes(@selected_persona == "developer")}
        >
          <p class="text-sm font-semibold text-emerald-200">I’m a developer</p>
          <p class="mt-2 text-sm text-zinc-200">Dive into stack details, architecture, and code samples.</p>
        </article>
        <article
          phx-click="select_persona"
          phx-value-persona="curious"
          phx-target={@target}
          class={card_classes(@selected_persona == "curious")}
        >
          <p class="text-sm font-semibold text-emerald-200">I’m just curious</p>
          <p class="mt-2 text-sm text-zinc-200">See a quick story, side projects, and music.</p>
        </article>
      </div>
    </section>
    """
  end

  defp card_classes(true) do
    [
      "group rounded-2xl border bg-zinc-900/90 p-6 shadow-lg shadow-emerald-500/20 backdrop-blur transition hover:-translate-y-1 hover:shadow-emerald-500/30",
      "border-emerald-400/80"
    ]
  end

  defp card_classes(false) do
    [
      "group rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-lg shadow-black/30 backdrop-blur transition hover:-translate-y-1 hover:border-emerald-400/60 hover:shadow-emerald-500/20"
    ]
  end
end
