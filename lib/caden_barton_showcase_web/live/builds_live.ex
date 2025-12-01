defmodule CadenBartonShowcaseWeb.BuildsLive do
  use CadenBartonShowcaseWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <section class="space-y-4">
        <h1 class="text-3xl font-bold">Recent builds (stub)</h1>
        <p class="text-zinc-300">
          A curated list of Phoenix and Elixir projects will appear here.
        </p>
      </section>
    </Layouts.app>
    """
  end
end
