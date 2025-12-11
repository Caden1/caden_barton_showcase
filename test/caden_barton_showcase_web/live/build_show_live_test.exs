defmodule CadenBartonShowcaseWeb.BuildShowLiveTest do
  use CadenBartonShowcaseWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "build show renders sections for a known slug", %{conn: conn} do
    slug = "realtime-ops-console"

    {:ok, view, _html} = live(conn, ~p"/builds/#{slug}")

    assert has_element?(view, "#build-heading")
    assert has_element?(view, "#build-context-section")
    assert has_element?(view, "#build-approach-section")
    assert has_element?(view, "#build-outcome-section")
    assert has_element?(view, "header a[href='#{~p"/"}']")
    assert has_element?(view, "a[href='/#section-how-i-work']")
    assert has_element?(view, "a[href='/#section-builds']")
  end

  test "build show renders not-found view for unknown slug", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/builds/non-existent-slug")

    assert has_element?(view, "#build-not-found")
    assert has_element?(view, "#builds-back-link")
    assert has_element?(view, "#builds-back-link[href='/#section-builds']")
  end
end
