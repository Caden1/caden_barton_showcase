defmodule CadenBartonShowcaseWeb.HowIWorkLive do
  use CadenBartonShowcaseWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <section class="space-y-4">
        <h1 class="text-3xl font-bold">How I work (stub)</h1>
        <p class="text-zinc-300">
          I’ll share process notes on architecture, delivery habits, and collaboration soon.
        </p>
      </section>
    </Layouts.app>
    """
  end
end
