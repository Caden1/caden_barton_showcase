defmodule CadenBartonShowcaseWeb.PageController do
  use CadenBartonShowcaseWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
