defmodule StorexWeb.CartController do
  use StorexWeb, :controller
  alias Storex.{Store, Sales}
  alias StorexWeb.Plugs

  def show(conn, _params) do
    cart = Plugs.Cart.get(conn)
    items = Sales.list_line_items(cart)
    total = Sales.line_items_total_price(items)
    render conn, "show.html", items: items, total: total
  end

  def create(conn, %{"book_id" => book_id}) do
    cart = Plugs.Cart.get(conn)
    book = Store.get_book(book_id)
    Sales.add_book_to_cart(book, cart)

    redirect(conn, to: cart_path(conn, :show))
  end

  def delete(conn, %{"book_id" => book_id}) do
    cart = Plugs.Cart.get(conn)
    book = Store.get_book(book_id)
    Sales.remove_book_from_cart(book, cart)

    redirect(conn, to: cart_path(conn, :show))
  end
end
