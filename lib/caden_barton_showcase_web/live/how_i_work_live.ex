defmodule CadenBartonShowcaseWeb.HowIWorkLive do
  use CadenBartonShowcaseWeb, :live_view

  import CadenBartonShowcaseWeb.HowIWorkComponent

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.how_i_work />
    </Layouts.app>
    """
  end
end
