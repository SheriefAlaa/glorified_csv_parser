defmodule OtpCsvParser.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :name_ar, :string
    field :name_en, :string

    timestamps()
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
