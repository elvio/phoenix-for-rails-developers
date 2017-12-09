defmodule StorexWeb.Plugs.Cart do
  import Plug.Conn
  alias Storex.Sales

  @session_name :cart_id
  @assign_name :cart

  def init(opts), do: opts

  def call(conn, _opts) do
    cart_id = get_session(conn, @session_name)

    cond do
      cart = cart_id && Sales.get_cart!(cart_id) ->
        assign(conn, @assign_name, cart)
      true ->
        {:ok, cart} = Sales.create_cart()

        conn
        |> put_session(@session_name, cart.id)
        |> assign(@assign_name, cart)
    end
  end

  def get(conn) do
    conn.assigns[@assign_name]
  end

  def forget(conn) do
    delete_session(conn, @session_name)
  end
end
