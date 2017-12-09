defmodule Storex.Repo.Migrations.CreateSalesCarts do
  use Ecto.Migration

  def change do
    create table(:sales_carts) do

      timestamps()
    end

  end
end
