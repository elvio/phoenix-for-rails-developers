defmodule Storex.Repo.Migrations.CreateSalesCarts do
  use Ecto.Migration

  def change do
    alter table(:sales_carts) do
      timestamps()
    end

    create index(:sales_line_items, [:order_id])
  end
end
