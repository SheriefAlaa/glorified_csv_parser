defmodule OtpCsvParserWeb.Api.Schema do
  use Absinthe.Schema

  alias OtpCsvParserWeb.Api.{Resolvers, Types}
  import_types(Types.CustomScalers)
  import_types(Types.Report)
  import_types(Absinthe.Plug.Types)

  query do
    @desc "Get CSV parsing failure reasons."
    field :get_failure_reasons, list_of(:failure_reasons) do
      arg(:process_id, non_null(:string))
      resolve(&Resolvers.ParseServerClient.failure_reasons/3)
    end
  end

  mutation do
    @desc "Get a new process ID to process a single CSV file."
    field :generate_process_id, non_null(:string) do
      resolve(&Resolvers.ParseServerClient.generate_process_id/3)
    end

    @desc "Upload CSV file endpoint. Requires Process ID and file."
    field :upload_file, :string do
      arg(:process_id, non_null(:string))
      arg(:data, non_null(:upload))
      resolve(&Resolvers.ParseServerClient.parse_csv_file/3)
    end
  end

  subscription do
    @desc "Subscribe to parsing/processing progress report"
    field :live_report, non_null(:report) do
      arg :process_id, non_null(:string)

      config(fn
        %{process_id: process_id}, _context ->
          {:ok, topic: "#{process_id}"}

        _args, _context ->
          {:error, "Please provide a valid process ID."}
      end)
    end
  end
end
