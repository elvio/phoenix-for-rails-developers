defmodule StorexWeb.Plugs.AdminOnly do
  import Plug.Conn
  alias StorexWeb.Plugs

  def init(opts), do: opts

  def call(conn, _opts) do
    if Plugs.CurrentUser.is_admin?(conn) do
      conn
    else
      conn
      |> put_resp_content_type("text/plain")
      |> send_resp(:forbidden, "forbidden")
      |> halt()
    end
  end
end
