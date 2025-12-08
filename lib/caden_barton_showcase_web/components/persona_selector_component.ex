defmodule CadenBartonShowcaseWeb.PersonaSelectorComponent do
  use Phoenix.Component

  attr :id, :string, required: true

  def persona_selector(assigns) do
    ~H"""
    <section id={@id} class="relative mx-auto max-w-6xl px-6 pb-4">
      <div class="space-y-3">
        <h2 class="font-display text-3xl font-bold sm:text-4xl text-zinc-50">Start here</h2>
        <p class="text-zinc-200">Tell me who you are and I’ll show you what to read.</p>
      </div>

      <div class="mt-8 grid gap-4 sm:gap-6 md:grid-cols-3">
        <a href="#for-hiring-managers" class={card_classes()}>
          <p class="text-sm font-semibold text-emerald-200">I’m a hiring manager</p>
          <p class="mt-2 text-sm text-zinc-200">
            Get a quick overview of how I work and what I’ve shipped.
          </p>
        </a>
        <a href="#section-projects" class={card_classes()}>
          <p class="text-sm font-semibold text-emerald-200">I’m a developer</p>
          <p class="mt-2 text-sm text-zinc-200">
            Dive into stack details, architecture, and code samples.
          </p>
        </a>
        <a href="#section-about-me" class={card_classes()}>
          <p class="text-sm font-semibold text-emerald-200">I’m just curious</p>
          <p class="mt-2 text-sm text-zinc-200">See a quick story, side projects, and music.</p>
        </a>
      </div>
    </section>
    """
  end

  defp card_classes do
    [
      "group rounded-2xl border border-zinc-800 bg-zinc-950/70 p-6 shadow-lg shadow-black/30 backdrop-blur transition hover:-translate-y-1 hover:border-emerald-400/60 hover:shadow-emerald-500/20",
      "focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-emerald-400",
      "block"
    ]
  end
end
