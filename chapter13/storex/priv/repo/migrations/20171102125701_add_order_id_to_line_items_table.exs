defmodule Storex.Repo.Migrations.AddOrderIdToLineItemsTable do
  use Ecto.Migration

  def change do
    alter table(:sales_line_items) do
      add :order_id, references(:sales_orders, on_delete: :nothing)
    end

    create index(:sales_line_items, [:order_id])
  end
end
