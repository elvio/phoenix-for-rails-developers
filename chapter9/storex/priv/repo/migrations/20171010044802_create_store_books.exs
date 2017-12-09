defmodule Storex.Repo.Migrations.CreateStoreBooks do
  use Ecto.Migration

  def change do
    create table(:store_books) do
      add :title, :string
      add :description, :text
      add :price, :decimal, precision: 4, scale: 2 
      add :image_url, :string

      timestamps()
    end

  end
end
