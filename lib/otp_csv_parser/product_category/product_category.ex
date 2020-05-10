defmodule OtpCsvParser.ProductCategory do
  use Ecto.Schema
  import Ecto.Changeset

  alias OtpCsvParser.{Products.Product, Categories.Category}

  @primary_key false

  schema "product_category_m2m" do
    belongs_to(:category, Category)
    belongs_to(:product, Product)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:product_id, :category_id])
    |> validate_required([:product_id, :category_id])
  end
end
