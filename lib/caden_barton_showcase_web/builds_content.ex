defmodule CadenBartonShowcaseWeb.BuildsContent do
  @moduledoc false

  def builds do
    [
      %{
        slug: "realtime-ops-console",
        name: "Real-time Ops Console",
        summary: "LiveView console for fleet health with streaming telemetry and guardrails.",
        role: "Technical lead across Phoenix, LiveView UX, and rollout safety.",
        problem:
          "Oncall teams lacked a unified view of deploy state, incidents, and service health.",
        approach:
          "Phoenix contexts with LiveView streams, structured telemetry, and playbooks surfaced inline for operators.",
        outcome: "Reduced mean time to respond by 35% with actionable alerts and drill-downs."
      },
      %{
        slug: "event-pipeline",
        name: "Event Pipeline & Analytics",
        summary: "Redpanda + ClickHouse pipeline ingesting billions of events per day.",
        role: "Architected ingestion, schemas, and back-pressure controls; built observability.",
        problem: "Legacy pipeline dropped events under burst load and lacked cost controls.",
        approach:
          "Modeled schemas for ClickHouse, enforced contracts at ingress, and tuned consumers with budgets and retries.",
        outcome: "Handles bursty traffic without loss; analytics queries 10x faster and cheaper."
      },
      %{
        slug: "multitenant-api",
        name: "Multi-tenant API Platform",
        summary: "Phoenix contexts with strict tenancy and reversible migrations.",
        role: "Led API design, tenancy enforcement, and feature-flagged releases.",
        problem: "Shared data models risked cross-tenant leakage and painful deploys.",
        approach:
          "Per-tenant boundary modules, scoped queries, and migration playbooks with feature flags and backfills.",
        outcome: "Zero tenant leaks post-migration and boring deploys with reversible changes."
      }
    ]
  end

  def projects, do: builds()

  def get_project(slug) do
    Enum.find(builds(), &(&1.slug == slug))
  end
end
