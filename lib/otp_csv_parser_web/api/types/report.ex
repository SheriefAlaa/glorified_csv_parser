defmodule OtpCsvParserWeb.Api.Types.Report do
  use Absinthe.Schema.Notation

  object :report do
    field :success, non_null(:integer)
    field :failure, non_null(:integer)
    field :remaining_rows, non_null(:integer)
  end

  object :failure_reasons do
    field :id, non_null(:integer)
    field :name_ar, list_of(:string)
    field :name_en, list_of(:string)
    field :description_ar, list_of(:string)
    field :description_en, list_of(:string)
    field :listed, list_of(:string)
    field :price, list_of(:string)
    field :inserted_at, list_of(:string)
    field :updated_at, list_of(:string)
  end
end
