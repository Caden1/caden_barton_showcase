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
            <a
              href={~p"/"}
              class="rounded-md px-3 py-2 transition hover:-translate-y-0.5 hover:text-emerald-300"
            >
              Home
            </a>
            <a
              id="nav-how-i-work"
              href="/#section-how-i-work"
              phx-hook="ScrollToSectionLink"
              data-scroll-target="section-how-i-work"
              class="rounded-md px-3 py-2 transition hover:-translate-y-0.5 hover:text-emerald-300"
            >
              How I work
            </a>
            <a
              id="nav-builds"
              href="/#section-builds"
              phx-hook="ScrollToSectionLink"
              data-scroll-target="section-builds"
              class="rounded-md px-3 py-2 transition hover:-translate-y-0.5 hover:text-emerald-300"
            >
              Builds
            </a>
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
    <div class="card relative flex flex-row items-center border-2 border-base-300 bg-base-300 rounded-full">
      <div class="absolute w-1/3 h-full rounded-full border-1 border-base-200 bg-base-100 brightness-200 left-0 [[data-theme=light]_&]:left-1/3 [[data-theme=dark]_&]:left-2/3 transition-[left]" />

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
      >
        <.icon name="hero-computer-desktop-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
      >
        <.icon name="hero-sun-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
      >
        <.icon name="hero-moon-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>
    </div>
    """
  end
end
