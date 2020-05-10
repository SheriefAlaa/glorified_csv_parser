defmodule OtpCsvParser.Factory do
  use ExMachina.Ecto, repo: OtpCsvParser.Repo

  def product_category_factory do
    %OtpCsvParser.ProductCategory{
      category_id: nil,
      product_id: nil
    }
  end

  def product_factory do
    %OtpCsvParser.Products.Product{
      name_ar: "باب",
      name_en: "door",
      description_ar: "",
      description_en: "",
      listed: true,
      price: 1.2
    }
  end

  def category_factory do
    %OtpCsvParser.Categories.Category{
      name_ar: "اثاث",
      name_en: "Furniture"
    }
  end
end
