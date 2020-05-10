defmodule OtpCsvParser.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset

  alias OtpCsvParser.Products.Product

  schema "categories" do
    field :name_ar, :string
    field :name_en, :string

    timestamps()

    many_to_many(:products, Product, join_through: "product_categories")
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name_ar, :name_en])
    |> validate_required([:name_ar, :name_en])
    |> unique_constraint(:name_ar)
    |> unique_constraint(:name_en)
  end
end
