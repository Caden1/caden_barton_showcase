defmodule CadenBartonShowcaseWeb.PersonaSelectorComponentTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias CadenBartonShowcaseWeb.PersonaSelectorComponent

  test "renders labels and highlights recruiter persona" do
    html =
      render_component(&PersonaSelectorComponent.persona_selector/1,
        id: "start-here",
        selected_persona: "recruiter"
      )

    {:ok, doc} = Floki.parse_document(html)

    recruiter_nodes =
      doc
      |> Floki.find("article[phx-value-persona='recruiter']")

    assert length(recruiter_nodes) == 1
    assert Floki.text(recruiter_nodes) =~ "I’m a hiring manager"

    developer_nodes =
      doc
      |> Floki.find("article[phx-value-persona='developer']")

    assert length(developer_nodes) == 1
    assert Floki.text(developer_nodes) =~ "I’m a developer"

    curious_nodes =
      doc
      |> Floki.find("article[phx-value-persona='curious']")

    assert length(curious_nodes) == 1
    assert Floki.text(curious_nodes) =~ "I’m just curious"

    recruiter_classes =
      doc
      |> Floki.find("article[phx-value-persona='recruiter']")
      |> Floki.attribute("class")
      |> List.first()

    assert recruiter_classes =~ "border-emerald-400/80"
  end

  test "highlights developer when selected" do
    html =
      render_component(&PersonaSelectorComponent.persona_selector/1,
        id: "start-here",
        selected_persona: "developer"
      )

    developer_classes =
      html
      |> Floki.parse_document!()
      |> Floki.find("article[phx-value-persona='developer']")
      |> Floki.attribute("class")
      |> List.first()

    assert developer_classes =~ "border-emerald-400/80"
  end
end
