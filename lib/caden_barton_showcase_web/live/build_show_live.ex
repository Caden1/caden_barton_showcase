defmodule CadenBartonShowcaseWeb.BuildShowLive do
  use CadenBartonShowcaseWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"slug" => slug}, _uri, socket) do
    {:noreply, assign(socket, :slug, slug)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <section class="space-y-4">
        <h1 class="text-3xl font-bold">Build detail</h1>
        <p class="text-zinc-300">
          Build detail for: {@slug} (stub)
        </p>
      </section>
    </Layouts.app>
    """
  end
end
