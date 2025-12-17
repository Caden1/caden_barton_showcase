defmodule CadenBartonShowcaseWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use CadenBartonShowcaseWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  attr :full_bleed, :boolean, default: false
  attr :tour_state, :map, default: nil
  attr :tour_steps, :list, default: []

  slot :inner_block, required: true

  def app(assigns) do
    assigns =
      assigns
      |> assign(
        :tour_state,
        assigns[:tour_state] || CadenBartonShowcaseWeb.HiringManagerTourState.new()
      )
      |> assign(
        :tour_steps,
        assigns[:tour_steps] || CadenBartonShowcaseWeb.HiringManagerTourContent.steps()
      )

    assigns =
      assign(assigns, :tour_progress, build_progress(assigns.tour_state, assigns.tour_steps))

    ~H"""
    <%= if @full_bleed do %>
      {render_slot(@inner_block)}
    <% else %>
      <%= if @tour_state.active? do %>
        <div class="sticky top-0 z-50 border-b border-emerald-900/40 bg-emerald-950/80 backdrop-blur">
          <div class="mx-auto flex max-w-6xl items-center justify-between gap-4 px-4 py-3 sm:px-6 lg:px-8">
            <div class="flex items-center gap-3">
              <span class="inline-flex items-center justify-center rounded-full bg-emerald-500/20 px-3 py-1 text-xs font-semibold text-emerald-200">
                Hiring Manager Tour
              </span>
              <div class="flex items-center gap-2 text-xs text-emerald-100/80">
                <%= for step <- @tour_progress do %>
                  <div class={[
                    "flex items-center gap-1 rounded-full border px-2 py-1",
                    step.status == :completed &&
                      "border-emerald-500/60 bg-emerald-900/40 text-emerald-100",
                    step.status == :current && "border-amber-400/60 bg-amber-900/30 text-amber-100",
                    step.status == :upcoming &&
                      "border-emerald-800/60 bg-emerald-950/40 text-emerald-200/70"
                  ]}>
                    <div class={[
                      "h-2 w-2 rounded-full",
                      step.status == :completed && "bg-emerald-400",
                      step.status == :current && "bg-amber-300",
                      step.status == :upcoming && "bg-emerald-700"
                    ]} />
                    <.link
                      navigate={step.path}
                      class="text-[11px] font-semibold transition hover:text-emerald-100"
                    >
                      {step.label}
                    </.link>
                  </div>
                <% end %>
              </div>
            </div>

            <div class="flex items-center gap-2">
              <button
                type="button"
                class="rounded-lg border border-emerald-500/60 px-3 py-1.5 text-xs font-semibold text-emerald-100 transition hover:-translate-y-0.5 hover:border-emerald-300"
                phx-click="tour_skip"
              >
                Skip step
              </button>
              <button
                type="button"
                class="rounded-lg bg-emerald-500 px-3 py-1.5 text-xs font-semibold text-emerald-950 shadow hover:bg-emerald-400"
                phx-click="tour_exit"
              >
                Exit tour
              </button>
            </div>
          </div>
        </div>
      <% end %>

      <header class="px-4 py-6 sm:px-6 lg:px-8">
        <div class="mx-auto flex max-w-6xl items-center justify-between">
          <.link
            navigate={~p"/"}
            class="flex items-center gap-2 text-lg font-semibold text-zinc-900 dark:text-zinc-50"
          >
            <span class="inline-flex h-9 w-9 items-center justify-center rounded-xl bg-emerald-500/20 text-emerald-300">
              CB
            </span>
            <span>Caden Barton</span>
          </.link>

          <nav class="flex items-center gap-4 text-sm font-semibold text-zinc-700 dark:text-zinc-200">
            <.link
              navigate={~p"/"}
              class="rounded-md px-3 py-2 transition hover:-translate-y-0.5 hover:text-emerald-300"
            >
              Home
            </.link>
            <.link
              id="nav-how-i-work"
              navigate={~p"/how-i-work"}
              class="rounded-md px-3 py-2 transition hover:-translate-y-0.5 hover:text-emerald-300"
            >
              How I work
            </.link>
            <.link
              id="nav-builds"
              navigate={~p"/builds"}
              class="rounded-md px-3 py-2 transition hover:-translate-y-0.5 hover:text-emerald-300"
            >
              Builds
            </.link>
            <.theme_toggle />
          </nav>
        </div>
      </header>

      <main class="px-4 py-20 sm:px-6 lg:px-8">
        <div class="mx-auto max-w-2xl space-y-4">
          {render_slot(@inner_block)}
        </div>
      </main>
    <% end %>

    <div id="tour-persistence-hook" phx-hook="HiringManagerTourPersistence" class="hidden"></div>

    <.flash_group flash={@flash} />
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Provides dark vs light theme toggle based on themes defined in app.css.

  See <head> in root.html.heex which applies the theme before page load.
  """
  def theme_toggle(assigns) do
    ~H"""
    <div class="card relative flex flex-row items-center rounded-full border-2 border-base-300 bg-base-300">
      <div class="absolute left-0 h-full w-1/2 rounded-full border-1 border-base-200 bg-base-100 brightness-200 transition-[left] [[data-theme=light]_&]:left-1/2" />

      <button
        class="flex w-1/2 cursor-pointer items-center justify-center gap-1 p-2 text-xs font-semibold"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
      >
        <.icon name="hero-moon" class="size-4 opacity-80" /> Dark
      </button>

      <button
        class="flex w-1/2 cursor-pointer items-center justify-center gap-1 p-2 text-xs font-semibold"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
      >
        <.icon name="hero-sun" class="size-4 opacity-80" /> Light
      </button>
    </div>
    """
  end

  defp build_progress(%{active?: true} = state, steps) do
    Enum.map(steps, fn step ->
      cond do
        MapSet.member?(state.completed_step_ids, step.id) -> Map.put(step, :status, :completed)
        step.id == state.current_step_id -> Map.put(step, :status, :current)
        true -> Map.put(step, :status, :upcoming)
      end
    end)
  end

  defp build_progress(_state, steps), do: Enum.map(steps, &Map.put(&1, :status, :upcoming))
end
