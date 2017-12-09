defmodule StorexWeb.Plugs.ItemsCount do
  import Plug.Conn
  alias Storex.Sales
  alias StorexWeb.Plugs

  @assign_name :items_count

  def init(opts), do: opts

  def call(conn, _opts) do
    cart       = Plugs.Cart.get(conn)
    line_items = Sales.list_line_items(cart)

    assign(conn, @assign_name, Sales.line_items_quantity_count(line_items))
  end

  def get(conn) do
    conn.assigns[@assign_name]
  end
end
