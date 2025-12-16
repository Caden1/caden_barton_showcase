defmodule CadenBartonShowcaseWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use CadenBartonShowcaseWeb, :html

  alias CadenBartonShowcaseWeb.QuestContent
  alias CadenBartonShowcaseWeb.QuestState

  import CadenBartonShowcaseWeb.QuestOverlayComponent

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

  attr :quest_state, :map, default: nil
  attr :quests, :map, default: nil
  attr :full_bleed, :boolean, default: false

  slot :inner_block, required: true

  def app(assigns) do
    assigns =
      assigns
      |> assign(:quest_state, assigns[:quest_state] || QuestState.new())
      |> assign(:quests, assigns[:quests] || QuestContent.quests())

    ~H"""
    <%= if @full_bleed do %>
      {render_slot(@inner_block)}
    <% else %>
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

    <div id="quest-persistence-hook" phx-hook="QuestPersistence" class="hidden"></div>

    <.quest_overlay quest_state={@quest_state} quests={@quests} />

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
      <div class="absolute left-0 h-full w-1/3 rounded-full border-1 border-base-200 bg-base-100 brightness-200 transition-[left] [[data-theme=dark-synth]_&]:left-1/3 [[data-theme=cyberpunk]_&]:left-2/3" />

      <button
        class="flex w-1/3 cursor-pointer items-center justify-center gap-1 p-2 text-xs font-semibold"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="synthwave"
      >
        <.icon name="hero-sparkles" class="size-4 opacity-80" />
        Synthwave
      </button>

      <button
        class="flex w-1/3 cursor-pointer items-center justify-center gap-1 p-2 text-xs font-semibold"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark-synth"
      >
        <.icon name="hero-bolt" class="size-4 opacity-80" />
        Dark Synth
      </button>

      <button
        class="flex w-1/3 cursor-pointer items-center justify-center gap-1 p-2 text-xs font-semibold"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="cyberpunk"
      >
        <.icon name="hero-cpu-chip" class="size-4 opacity-80" />
        Cyberpunk
      </button>
    </div>
    """
  end
end
