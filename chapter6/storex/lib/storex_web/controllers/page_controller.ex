defmodule StorexWeb.PageController do
  use StorexWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
