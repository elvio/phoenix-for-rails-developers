defmodule Storex.Sales.LineItem do
  use Ecto.Schema
  import Ecto.Changeset
  alias Storex.Sales.LineItem

  schema "sales_line_items" do
    belongs_to :cart, Storex.Sales.Cart
    belongs_to :book, Storex.Store.Book
    field :quantity, :integer
    timestamps()
  end

  def changeset(%LineItem{} = line_item, attrs) do
    line_item
    |> cast(attrs, [:quantity])
    |> validate_required([:quantity])
  end
end
