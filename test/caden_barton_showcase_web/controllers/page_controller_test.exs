defmodule CadenBartonShowcaseWeb.PageControllerTest do
  use CadenBartonShowcaseWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    html = html_response(conn, 200)

    assert html =~ "AI-assisted workflow I trust."
    assert html =~ "resilient Elixir systems"
  end
end
