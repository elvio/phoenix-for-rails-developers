defmodule StorexWeb.BookController do
  use StorexWeb, :controller
  alias Storex.Store
  plug StorexWeb.Plugs.AdminOnly when action not in [:index, :show]  

  def index(conn, _params) do
    render conn, "index.html", books: Store.list_books()
  end

  def show(conn, %{"id" => book_id}) do
    render conn, "show.html", book: Store.get_book(book_id)
  end

  def new(conn, _params) do
    changeset = Store.change_book()
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"book" => book_params}) do
    case Store.create_book(book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book created")
        |> redirect to: "/"

      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => book_id}) do
    book = Store.get_book(book_id)
    changeset = Store.change_book(book)

    render conn, "edit.html", changeset: changeset, book: book
  end

  def update(conn, %{"id" => book_id, "book" => book_params}) do
    book = Store.get_book(book_id)

    case Store.update_book(book, book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book updated")
        |> redirect to: "/"

      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset
    end
  end

  def delete(conn, %{"id" => book_id}) do
    book = Store.get_book(book_id)
    Store.delete_book(book)

    conn
    |> put_flash(:info, "Book deleted")
    |> redirect to: "/"
  end
end
