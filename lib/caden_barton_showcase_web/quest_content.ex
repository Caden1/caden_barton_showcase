defmodule CadenBartonShowcaseWeb.QuestContent do
  @moduledoc false

  @quests %{
    "hiring_manager" => %{
      title: "Hiring manager signals",
      reward: "Hiring-ready checklist and talking points",
      steps: [
        %{id: "hm-fit", label: "Check fit for hiring managers", target_id: "for-hiring-managers"},
        %{id: "hm-workflow", label: "See how I run delivery", target_id: "section-how-i-work"},
        %{
          id: "hm-ai-loop",
          label: "Review AI delivery loop",
          target_id: "section-ai-delivery-loop"
        },
        %{id: "hm-case-study", label: "Read the case study", target_id: "case-study"},
        %{id: "hm-builds", label: "Browse recent builds", target_id: "section-builds"}
      ]
    },
    "developer" => %{
      title: "Pair with the stack",
      reward: "Implementation notes you can reuse",
      steps: [
        %{id: "dev-workflow", label: "Skim the workflow", target_id: "section-how-i-work"},
        %{
          id: "dev-loop",
          label: "Dive into the AI delivery loop",
          target_id: "section-ai-delivery-loop"
        },
        %{id: "dev-projects", label: "Scan projects", target_id: "case-study"},
        %{id: "dev-builds", label: "See the builds gallery", target_id: "section-builds"}
      ]
    },
    "curious" => %{
      title: "Curious visitor",
      reward: "Quick highlights tour",
      steps: [
        %{
          id: "curious-intro",
          label: "Start with the hiring manager overview",
          target_id: "for-hiring-managers"
        },
        %{id: "curious-work", label: "How I work", target_id: "section-how-i-work"},
        %{id: "curious-loop", label: "AI delivery loop", target_id: "section-ai-delivery-loop"},
        %{id: "curious-case", label: "Case study", target_id: "case-study"},
        %{id: "curious-projects", label: "Projects list", target_id: "section-builds"}
      ]
    }
  }

  def quests, do: @quests
end
