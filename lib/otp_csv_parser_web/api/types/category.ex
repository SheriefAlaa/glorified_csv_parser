defmodule OtpCsvParserWeb.Api.Types.Category do
  use Absinthe.Schema.Notation

  object :category do
    field :id, non_null(:integer)
    field :name_ar, non_null(:string)
    field :name_en, non_null(:string)
    field :inserted_at, non_null(:date)
    field :updated_at, non_null(:date)
  end
end
