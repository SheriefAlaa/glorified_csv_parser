defmodule OtpCsvParser.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias OtpCsvParser.Categories.Category

  schema "products" do
    # Inherited fields from categories table.
    field :name_ar, :string
    field :name_en, :string

    # Local fields.
    field :description_ar, :string
    field :description_en, :string
    field :listed, :boolean, default: true
    field :price, :decimal

    many_to_many(:categories, Category, join_through: "product_categories")

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name_ar, :name_en, :description_ar, :description_en, :price, :listed])
    |> validate_required([:price])
    |> validate_number(:price, greater_than: 0)
    |> unique_constraint(:name_ar)
    |> unique_constraint(:name_en)
  end
end
