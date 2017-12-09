defmodule Storex.Repo.Migrations.CreateSalesLineItems do
  use Ecto.Migration

  def change do
    create table(:sales_line_items) do
      add :quantity, :integer
      add :book_id, references(:store_books, on_delete: :nothing)
      add :cart_id, references(:sales_carts, on_delete: :nothing)

      timestamps()
    end

    create index(:sales_line_items, [:book_id])
    create index(:sales_line_items, [:cart_id])
  end
end
