defmodule StorexWeb.LayoutView do
  use StorexWeb, :view

  def items_count(conn) do
    StorexWeb.Plugs.ItemsCount.get(conn)
  end
end
