defmodule CadenBartonShowcaseWeb.ProofUnlocksComponent do
  @moduledoc false
  use CadenBartonShowcaseWeb, :html

  @cards [
    %{
      id: "proof-signals",
      title: "Hiring signals",
      hint: "Complete 2 quest steps to unlock my hiring signals",
      body: "What hiring managers get, the guardrails I set, and how I keep risk low.",
      link: %{label: "View hiring signals", href: "#for-hiring-managers"}
    },
    %{
      id: "proof-workflow",
      title: "Delivery workflow",
      hint: "Complete 4 steps to unlock workflow proof",
      body: "Step-by-step AI-assisted delivery loop with observable, reversible changes.",
      link: %{label: "See the workflow", href: "#section-ai-delivery-loop"}
    },
    %{
      id: "proof-case-study",
      title: "Case study",
      hint: "Finish the quest to unlock the case study",
      body:
        "A walkthrough of this site’s build and how I use ChatGPT, CODEX, and CodeRabbit together.",
      link: %{label: "Read the case study", href: "#case-study"}
    },
    %{
      id: "incident-winner",
      title: "Incident simulator",
      hint: "Beat the incident simulator to unlock",
      body:
        "Simulated hotfix with metrics, flags, and rollback guarded by a small state machine.",
      link: %{label: "Run the simulator", href: "/simulator/incident"}
    }
  ]

  attr :unlocked_ids, :any, required: true

  def proof_unlocks(assigns) do
    assigns =
      assigns
      |> assign(:cards, @cards)
      |> assign(:unlocked, MapSet.new(assigns.unlocked_ids))

    ~H"""
    <div id="proof-unlocks" class="mt-6 grid gap-4 md:grid-cols-3">
      <div
        :for={card <- @cards}
        id={"proof-card-#{card.id}"}
        class={[
          "rounded-2xl border p-4 transition",
          MapSet.member?(@unlocked, card.id) &&
            "border-emerald-400/60 bg-emerald-900/20 shadow-lg shadow-emerald-900/20",
          !MapSet.member?(@unlocked, card.id) &&
            "border-emerald-900/50 bg-emerald-950/60"
        ]}
      >
        <div class="flex items-start justify-between gap-2">
          <div>
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">Proof</p>
            <h3 class="text-lg font-semibold text-emerald-100">{card.title}</h3>
          </div>
          <div
            class={[
              "inline-flex items-center gap-1 rounded-full px-2 py-1 text-xs font-semibold",
              MapSet.member?(@unlocked, card.id) &&
                "bg-emerald-500/20 text-emerald-100",
              !MapSet.member?(@unlocked, card.id) &&
                "bg-zinc-800 text-zinc-300"
            ]}
            data-status={if(MapSet.member?(@unlocked, card.id), do: "unlocked", else: "locked")}
          >
            <.icon
              name={
                if(MapSet.member?(@unlocked, card.id),
                  do: "hero-check-badge",
                  else: "hero-lock-closed"
                )
              }
              class="h-4 w-4"
            />
            <%= if MapSet.member?(@unlocked, card.id) do %>
              Unlocked
            <% else %>
              Locked
            <% end %>
          </div>
        </div>
        <div class="mt-3 space-y-2 text-sm text-emerald-100/90">
          <%= if MapSet.member?(@unlocked, card.id) do %>
            <p>{card.body}</p>
            <a
              id={"proof-card-link-#{card.id}"}
              href={card.link.href}
              class="inline-flex items-center gap-1 text-emerald-300 underline underline-offset-4 hover:text-emerald-100"
              phx-hook="ScrollToSectionLink"
              data-scroll-target={String.trim_leading(card.link.href, "#")}
            >
              {card.link.label}
              <span>→</span>
            </a>
          <% else %>
            <div class="flex items-center gap-2 text-emerald-200/80">
              <.icon name="hero-lock-closed" class="h-4 w-4" />
              <span>{card.hint}</span>
            </div>
          <% end %>
        </div>
      </div>
    </div>
    """
  end
end
