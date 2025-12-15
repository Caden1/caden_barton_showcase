defmodule CadenBartonShowcaseWeb.BuildsLive do
  use CadenBartonShowcaseWeb, :live_view

  alias CadenBartonShowcaseWeb.BuildsContent
  import CadenBartonShowcaseWeb.BuildsIndexComponent

  def mount(_params, _session, socket) do
    {:ok, assign(socket, projects: BuildsContent.projects())}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} quest_state={@quest_state} quests={@quests}>
      <.builds_index projects={@projects} />
    </Layouts.app>
    """
  end
end
