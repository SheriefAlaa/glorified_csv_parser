defmodule OtpCsvParserWeb.Api.Resolvers.ParseServerClient do
  alias OtpCsvParser.Server

  @max_rand_number 1_000_000

  def generate_process_id(_root, _args, _context) do
    process_id = "pid-#{Enum.random(1000..@max_rand_number)}"

    case Server.start_link(process_id) do
      {:ok, true} ->
        {:ok, process_id}

      _ ->
        {:error, :process_exists}
    end
  end

  def parse_csv_file(
        _,
        %{process_id: process_id, data: %{path: temp_path, filename: filename}},
        _
      ) do
    # Keep the file in tmp dir as Plug.upload will delete the file as soon
    # as the request is done.
    new_path = Path.join(System.tmp_dir!(), filename)
    File.cp!(temp_path, new_path)
    Server.parse_csv(process_id, new_path)
    {:ok, "File Received. Please subscribe for progress report."}
  end

  def parse_csv_file(_, _, _) do
    {:error, "Process id no longer valid or file path was wrong."}
  end

  def failure_reasons(_, %{process_id: process_id}, _) do
    Server.get_report(process_id)
  end
end
