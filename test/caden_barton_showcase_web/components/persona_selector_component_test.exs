defmodule CadenBartonShowcaseWeb.PersonaSelectorComponentTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias CadenBartonShowcaseWeb.PersonaSelectorComponent

  test "renders labels and links to the correct sections" do
    html = render_component(&PersonaSelectorComponent.persona_selector/1, id: "start-here")

    {:ok, doc} = Floki.parse_document(html)

    recruiter_nodes =
      Floki.find(doc, "a[href='#for-hiring-managers'][phx-hook='ScrollToSectionLink']")

    developer_nodes =
      Floki.find(doc, "a[href='#section-projects'][phx-hook='ScrollToSectionLink']")

    curious_nodes = Floki.find(doc, "a[href='#case-study'][phx-hook='ScrollToSectionLink']")

    assert length(recruiter_nodes) == 1
    assert Floki.attribute(recruiter_nodes, "data-scroll-target") == ["#for-hiring-managers"]
    assert Floki.text(recruiter_nodes) =~ "I’m a hiring manager"

    assert length(developer_nodes) == 1
    assert Floki.attribute(developer_nodes, "data-scroll-target") == ["#section-projects"]
    assert Floki.text(developer_nodes) =~ "I’m a developer"

    assert length(curious_nodes) == 1
    assert Floki.attribute(curious_nodes, "data-scroll-target") == ["#case-study"]
    assert Floki.text(curious_nodes) =~ "I’m just curious"
  end
end
