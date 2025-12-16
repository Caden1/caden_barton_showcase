defmodule CadenBartonShowcaseWeb.PageControllerTest do
  use CadenBartonShowcaseWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    html = html_response(conn, 200)

    assert html =~ "What brings you here?"
    assert html =~ "Skip intro"
  end

  test "GET /how-i-work redirects to home section", %{conn: conn} do
    conn = get(conn, ~p"/how-i-work")

    assert redirected_to(conn, 301) == "/home#section-how-i-work"
  end

  test "GET /builds redirects to home builds section", %{conn: conn} do
    conn = get(conn, ~p"/builds")

    assert redirected_to(conn, 301) == "/home#section-builds"
  end
end
