defmodule Storex.Sales do
  import Ecto.Query, warn: false
  alias Storex.Repo
  alias Storex.Sales.Cart
  alias Storex.Sales.LineItem

  def create_cart(attrs \\ %{}) do
    %Cart{}
    |> Cart.changeset(attrs)
    |> Repo.insert()
  end

  def get_cart!(id) do
    Repo.get!(Cart, id)
  end

  def add_book_to_cart(book, cart) do
    line_item = Repo.get_by(LineItem, book_id: book.id, cart_id: cart.id)

    if line_item do
      line_item
      |> LineItem.changeset(%{quantity: line_item.quantity + 1})
      |> Repo.update()
    else
      %LineItem{book_id: book.id, cart_id: cart.id}
      |> LineItem.changeset(%{quantity: 1})
      |> Repo.insert()
    end
  end

  def remove_book_from_cart(book, cart) do
    line_item = Repo.get_by!(LineItem, book_id: book.id, cart_id: cart.id)

    if line_item.quantity > 1 do
      line_item
      |> LineItem.changeset(%{quantity: line_item.quantity - 1})
      |> Repo.update()
    else
      Repo.delete!(line_item)
    end
  end

  def list_line_items(cart) do
    LineItem
    |> preload(:book)
    |> where(cart_id: ^cart.id)
    |> Repo.all()
  end

  def line_items_quantity_count(items) do
    Enum.reduce(items, 0, fn(item, acc) -> acc + item.quantity end)
  end

  def line_items_total_price(items) do
    Enum.reduce(items, Decimal.new(0), fn(item, acc) ->
      quantity = Decimal.new(item.quantity)
      partial = Decimal.mult(quantity, item.book.price)

      Decimal.add(acc, partial)
    end)
  end
end
