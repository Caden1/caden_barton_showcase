defmodule CadenBartonShowcaseWeb.PersonaSelectorComponentTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias CadenBartonShowcaseWeb.PersonaSelectorComponent

  test "renders labels and links to the correct sections" do
    html = render_component(&PersonaSelectorComponent.persona_selector/1, id: "start-here")

    {:ok, doc} = Floki.parse_document(html)

    recruiter_nodes = Floki.find(doc, "a[href='/hiring-manager']")
    developer_nodes = Floki.find(doc, "a[href='/case-study']")
    curious_nodes = Floki.find(doc, "a[href='/projects']")

    assert length(recruiter_nodes) == 1
    assert Floki.text(recruiter_nodes) =~ "I'm a hiring manager"

    assert length(developer_nodes) == 1
    assert Floki.text(developer_nodes) =~ "I'm a developer"

    assert length(curious_nodes) == 1
    assert Floki.text(curious_nodes) =~ "I'm just curious"
  end
end
