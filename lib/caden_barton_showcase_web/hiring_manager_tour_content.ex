defmodule CadenBartonShowcaseWeb.HiringManagerTourContent do
  @moduledoc false

  @steps [
    %{id: "start", label: "Overview", path: "/hiring-manager"},
    %{id: "light_mode", label: "Light mode", path: "/hiring-manager"},
    %{id: "how_i_work", label: "How I work", path: "/how-i-work"},
    %{id: "ai_loop", label: "AI delivery loop", path: "/ai-delivery-loop"},
    %{id: "case_study", label: "Case study", path: "/case-study"},
    %{id: "builds", label: "Builds", path: "/builds"}
  ]

  def steps, do: @steps

  def path_for(step_id) do
    @steps
    |> Enum.find_value(fn
      %{id: ^step_id, path: path} -> path
      _ -> nil
    end)
  end
end
