defmodule CadenBartonShowcaseWeb.PageControllerTest do
  use CadenBartonShowcaseWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    html = html_response(conn, 200)

    assert html =~ "AI-assisted workflow I trust."
    assert html =~ "resilient Elixir systems"
  end

  test "GET /how-i-work redirects to home section", %{conn: conn} do
    conn = get(conn, ~p"/how-i-work")

    assert redirected_to(conn, 301) == "/#section-how-i-work"
  end

  test "GET /builds redirects to home builds section", %{conn: conn} do
    conn = get(conn, ~p"/builds")

    assert redirected_to(conn, 301) == "/#section-builds"
  end
end
