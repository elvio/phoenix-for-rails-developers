defmodule StorexWeb.BookController do
  use StorexWeb, :controller
  alias Storex.Store

  def index(conn, _params) do
    render conn, "index.html", books: Store.list_books()
  end

  def show(conn, %{"id" => book_id}) do
    render conn, "show.html", book: Store.get_book(book_id)
  end
end
