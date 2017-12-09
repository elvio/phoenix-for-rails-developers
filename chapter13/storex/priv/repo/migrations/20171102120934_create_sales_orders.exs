defmodule Storex.Repo.Migrations.CreateSalesOrders do
  use Ecto.Migration

  def change do
    create table(:sales_orders) do
      add :address, :string
      add :user_id, references(:accounts_users, on_delete: :nothing)

      timestamps()
    end

    create index(:sales_orders, [:user_id])
  end
end
