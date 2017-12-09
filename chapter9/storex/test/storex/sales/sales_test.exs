defmodule Storex.SalesTest do
  use Storex.DataCase
  alias Storex.{Sales, Store}

  def book_fixture(attrs \\ %{}) do
    default_attrs = %{
      title: "Book1",
      description: "Description1",
      image_url: "book1.jpg",
      price: "29.90"
    }

    {:ok, book} = attrs
    |> Enum.into(default_attrs)
    |> Store.create_book()

    book
  end

  def cart_fixture() do
    {:ok, cart} = Sales.create_cart()

    cart
  end

  describe "carts" do
    alias Storex.Sales.Cart

    test "create_cart/0 creates a cart" do
      assert {:ok, %Cart{}} = Sales.create_cart()
    end

    test "get_cart!/1 returns a cart" do
      cart = cart_fixture()
      assert Sales.get_cart!(cart.id) == cart
    end

    test "add_book_to_cart/2 creates or increments a line_item" do
      book = book_fixture()
      cart = cart_fixture()

      {:ok, line_item1} = Sales.add_book_to_cart(book, cart)
      {:ok, line_item2} = Sales.add_book_to_cart(book, cart)

      assert line_item1.quantity == 1
      assert line_item1.book_id == book.id
      assert line_item1.cart_id == cart.id
      assert line_item1.id == line_item2.id
      assert line_item2.quantity == 2
    end

    test "remove_book_from_cart/2 decrements or deletes a line_item" do
      book = book_fixture()
      cart = cart_fixture()

      Sales.add_book_to_cart(book, cart)
      Sales.add_book_to_cart(book, cart)

      {:ok, line_item} = Sales.remove_book_from_cart(book, cart)
      assert line_item.quantity == 1

      Sales.remove_book_from_cart(book, cart)

      assert_raise Ecto.NoResultsError, fn ->
        Sales.remove_book_from_cart(book, cart)
      end
    end
  end

  test "list_line_items/1 list items that belongs to a cart" do
    book1 = book_fixture()
    book2 = book_fixture()
    cart1 = cart_fixture()
    cart2 = cart_fixture()

    Sales.add_book_to_cart(book1, cart1)
    Sales.add_book_to_cart(book2, cart2)

    [line_item1] = Sales.list_line_items(cart1)
    assert line_item1.book == book1

    [line_item2] = Sales.list_line_items(cart2)
    assert line_item2.book == book2
  end

  test "line_items_quantity_count/1 returns the total quantity of items" do
    book1 = book_fixture()
    book2 = book_fixture()
    cart  = cart_fixture()

    Sales.add_book_to_cart(book1, cart)
    Sales.add_book_to_cart(book1, cart)
    Sales.add_book_to_cart(book2, cart)

    line_items = Sales.list_line_items(cart)

    assert Sales.line_items_quantity_count(line_items) == 3
  end

  test "line_items_total_price/1 returns the total price of items" do
    book1 = book_fixture(price: "10.00")
    book2 = book_fixture(price: "15.00")
    cart  = cart_fixture()

    Sales.add_book_to_cart(book1, cart)
    Sales.add_book_to_cart(book1, cart)
    Sales.add_book_to_cart(book2, cart)

    line_items = Sales.list_line_items(cart)

    assert Sales.line_items_total_price(line_items) == Decimal.new("35.00")
  end
end
