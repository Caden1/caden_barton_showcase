defmodule CadenBartonShowcaseWeb.PageController do
  use CadenBartonShowcaseWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def how_i_work(conn, _params) do
    conn
    |> put_status(:moved_permanently)
    |> redirect(external: "/#section-how-i-work")
  end

  def builds(conn, _params) do
    conn
    |> put_status(:moved_permanently)
    |> redirect(external: "/#section-builds")
  end
end
