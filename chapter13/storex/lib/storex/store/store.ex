defmodule Storex.Store do
  alias Storex.Repo
  alias Storex.Store.Book

  def create_book(attrs) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  def list_books() do
    Repo.all(Book)
  end

  def get_book(id) do
    Repo.get(Book, id)
  end

  def change_book(book \\ %Book{}) do
    Book.changeset(book, %{})
  end

  def update_book(book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  def delete_book(book) do
    Repo.delete(book)
  end
end
