defmodule StorexWeb.BookController do
  use StorexWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", books: list_books()
  end

  def show(conn, %{"id" => book_id}) do
    render conn, "show.html", book: get_book(book_id)
  end

  def list_books() do
    [
      %{id: "1", title: "My first book", price: "15.9", description: "The first story", image_url: "/images/books/1.png"},
      %{id: "2", title: "My second book", price: "25.9", description: "The second story", image_url: "/images/books/2.png" },
      %{id: "3", title: "My third book", price: "35.9", description: "The third story", image_url: "/images/books/3.png"},
      %{id: "4", title: "My fourth book", price: "45.9", description: "The fourth story", image_url: "/images/books/4.png"}
    ]
  end

  def get_book(id) do
    Enum.find(list_books(), fn(book) -> book.id == id end)
  end
end
