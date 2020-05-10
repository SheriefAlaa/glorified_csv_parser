defmodule OtpCsvParser.Repo.Migrations.ManyToManyProductsCategories do
  use Ecto.Migration

  def up do
    # Many to many assoc products <- product_category_m2m -> categories
    create table(:product_category_m2m, primary_key: false) do
      add(:product_id, references(:products))
      add(:category_id, references(:categories))
    end
  end

  def down do
    drop(table(:product_category_m2m))
  end
end
