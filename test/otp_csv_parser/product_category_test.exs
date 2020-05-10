defmodule OmegaBravera.ProductCategoryTest do
  use OtpCsvParser.DataCase

  import OtpCsvParser.Factory
  alias OtpCsvParser.ProductCategory
  alias OtpCsvParser.Products

  describe "add_product/1" do
    test "adds an existing category to a product" do
      category = insert(:category)
      product = insert(:product)

      assert {:ok, %ProductCategory{} = product_category_relation} =
               Products.add_category(%{category_id: category.id, product_id: product.id})

      assert product_category_relation.category_id == category.id
      assert product_category_relation.product_id == product.id
    end
  end
end
