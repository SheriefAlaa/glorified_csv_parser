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

  def from_csv(data) when is_map(data) do
    %{
      name_ar: data["name_ar"],
      name_en: data["name_en"],
      description_ar: data["description_ar"],
      description_en: data["description_en"],
      listed: str_to_bool(data["listed"]),
      price: Decimal.new(data["price"])
    }
  end

  defp str_to_bool("TRUE"), do: true
  defp str_to_bool("FALSE"), do: false
  defp str_to_bool(_), do: true

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
