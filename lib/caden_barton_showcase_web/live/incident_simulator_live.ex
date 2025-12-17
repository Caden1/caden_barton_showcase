defmodule CadenBartonShowcaseWeb.IncidentSimulatorLive do
  use CadenBartonShowcaseWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> stream(:events, [])
      |> assign(:stage, :triage)
      |> assign(:progress, [])
      |> assign(:message, "Start triage by checking metrics.")
      |> assign(:sequence, [:check_metrics, :enable_flag, :rollback])
      |> assign(:tick, 0)
      |> assign(:current_scope, nil)

    if connected?(socket), do: schedule_tick()

    {:ok, socket}
  end

  @impl true
  def handle_info(:tick, socket) do
    tick = socket.assigns.tick + 1
    event = %{id: "evt-#{tick}", text: "Signal #{tick}: latency spike on api-gateway"}

    socket =
      socket
      |> assign(:tick, tick)
      |> stream(:events, [event])

    schedule_tick()

    {:noreply, socket}
  end

  @impl true
  def handle_event("action", %{"action" => _action}, %{assigns: %{stage: :victory}} = socket) do
    {:noreply, socket}
  end

  def handle_event("action", %{"action" => action}, socket) do
    action_atom =
      case action do
        "check_metrics" -> :check_metrics
        "enable_flag" -> :enable_flag
        "rollback" -> :rollback
        _ -> :unknown
      end

    case next_expected(socket.assigns.sequence, socket.assigns.progress) do
      ^action_atom ->
        progress = socket.assigns.progress ++ [action_atom]

        if length(progress) == length(socket.assigns.sequence) do
          {:noreply,
           socket
           |> assign(:stage, :victory)
           |> assign(:message, "Victory! Incident contained.")
           |> assign(:progress, progress)}
        else
          {:noreply,
           socket
           |> assign(:progress, progress)
           |> assign(
             :message,
             "Good move. Next step: #{next_expected(socket.assigns.sequence, progress)}"
           )}
        end

      _other ->
        {:noreply,
         socket
         |> assign(:stage, :triage)
         |> assign(:progress, [])
         |> assign(:message, "Wrong move. Restart triage: check metrics first.")}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app
      current_scope={@current_scope}
      flash={@flash}
      tour_state={@tour_state}
      tour_steps={@tour_steps}
    >
      <section class="mx-auto max-w-5xl px-6 py-10 space-y-8">
        <header class="flex items-center justify-between">
          <div>
            <p class="text-xs uppercase tracking-[0.2em] text-emerald-300">Incident Simulator</p>
            <h1 class="text-3xl font-semibold text-emerald-100">Contain the outage</h1>
            <p class="text-sm text-emerald-100/80">
              Check metrics, flip the feature flag, then roll back. Wrong order? You start over.
            </p>
          </div>
          <div class="rounded-full border border-emerald-500/50 bg-emerald-900/30 px-4 py-2 text-sm text-emerald-100">
            Stage: {stage_label(@stage)}
          </div>
        </header>

        <div class="grid gap-6 lg:grid-cols-3">
          <div class="lg:col-span-2 rounded-2xl border border-emerald-900/60 bg-emerald-950/70 p-4">
            <div class="flex items-center justify-between">
              <h2 class="text-lg font-semibold text-emerald-100">Live signals</h2>
              <span class="text-xs text-emerald-200/80">auto-refresh</span>
            </div>
            <div id="incident-events" phx-update="stream" class="mt-4 space-y-2">
              <div
                :for={{id, event} <- @streams.events}
                id={id}
                class="rounded-xl border border-emerald-900/60 bg-emerald-900/20 px-3 py-2 text-sm text-emerald-100"
              >
                {event.text}
              </div>
            </div>
          </div>

          <div class="space-y-4 rounded-2xl border border-emerald-900/60 bg-emerald-950/70 p-4">
            <div class="flex items-center justify-between">
              <h2 class="text-lg font-semibold text-emerald-100">Triage actions</h2>
              <span class="text-xs text-emerald-200/80">{@message}</span>
            </div>
            <div class="space-y-2">
              <button
                id="incident-action-check-metrics"
                class="w-full rounded-lg border border-emerald-500/60 px-4 py-2 text-left text-sm font-semibold text-emerald-100 hover:border-emerald-300"
                phx-click="action"
                phx-value-action="check_metrics"
              >
                Check metrics
              </button>
              <button
                id="incident-action-enable-flag"
                class="w-full rounded-lg border border-emerald-500/60 px-4 py-2 text-left text-sm font-semibold text-emerald-100 hover:border-emerald-300"
                phx-click="action"
                phx-value-action="enable_flag"
              >
                Enable feature flag guardrail
              </button>
              <button
                id="incident-action-rollback"
                class="w-full rounded-lg border border-emerald-500/60 px-4 py-2 text-left text-sm font-semibold text-emerald-100 hover:border-emerald-300"
                phx-click="action"
                phx-value-action="rollback"
              >
                Roll back deployment
              </button>
            </div>
          </div>
        </div>

        <%= if @stage == :victory do %>
          <div class="rounded-3xl border border-emerald-500/50 bg-emerald-900/20 p-6 text-emerald-50">
            <h2 class="text-2xl font-semibold">Victory! Incident contained.</h2>
            <p class="mt-2 text-sm text-emerald-100/80">
              You followed the guardrails in the right order. Head back to the hiring manager overview for more delivery signals.
            </p>
            <div class="mt-4">
              <.link
                navigate={~p"/hiring-manager"}
                class="inline-flex items-center gap-2 rounded-lg bg-emerald-500 px-4 py-2 text-sm font-semibold text-emerald-950 shadow hover:bg-emerald-400"
              >
                Return to overview <span>→</span>
              </.link>
            </div>
          </div>
        <% end %>
      </section>
    </Layouts.app>
    """
  end

  defp next_expected(sequence, progress) do
    Enum.at(sequence, length(progress))
  end

  defp stage_label(:triage), do: "Triage"
  defp stage_label(:victory), do: "Victory"

  defp schedule_tick do
    Process.send_after(self(), :tick, 1_200)
  end
end
