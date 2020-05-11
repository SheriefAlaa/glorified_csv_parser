defmodule OtpCsvParserWeb.Api.Types.Product do
  use Absinthe.Schema.Notation

  object :product do
    field :id, non_null(:integer)
    field :name_ar, non_null(:string)
    field :name_en, non_null(:string)
    field :description_ar, :string
    field :description_en, :string
    field :listed, non_null(:boolean)
    field :price, non_null(:decimal)
    field :inserted_at, non_null(:date)
    field :updated_at, non_null(:date)
  end
end
