defmodule OtpCsvParserWeb.Api.Types.CustomScalers do
  use Absinthe.Schema.Notation

  scalar :date do
    parse(fn input ->
      case Timex.parse(input.value, "{ISO:Extended}") do
        {:ok, iso_date} ->
          {:ok, date} = DateTime.from_naive(iso_date, "Etc/UTC")
          {:ok, date}

        _ ->
          :error
      end
    end)

    converted_date =
      try do
        DateTime.to_iso8601(date)
      catch
        Date.to_iso8601(date)
      end

    serialize(fn converted_date -> converted_date end)
  end

  scalar :decimal do
    parse(fn
      %{value: value}, _ ->
        Decimal.parse(value)

      _, _ ->
        :error
    end)

    serialize(&Decimal.to_float/1)
  end

  @desc "An error encountered trying to persist input"
  object :input_error do
    field(:key, non_null(:string))
    field(:message, non_null(:string))
  end
end
