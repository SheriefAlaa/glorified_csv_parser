defmodule OtpCsvParser.Server do
  use GenServer, restart: :transient

  require Logger
  alias OtpCsvParser.Cache
  alias OtpCsvParser.Products
  alias OtpCsvParser.Products.Product

  # 60 Minutes
  @terminate_after 1000 * 60 * 60

  @progress_report %{
    success: 0,
    failure: 0,
    remaining_rows: 0,
    failure_reasons: []
  }

  # Client interface
  def start_link(string_process_id) do
    case GenServer.start_link(__MODULE__, []) do
      {:ok, pid} ->
        Cache.create_process_report(string_process_id, @progress_report)
        Cache.create_process_entry(string_process_id, pid)

      error ->
        error
    end
  end

  def parse_csv(process_id_name, file) do
    Logger.info("Starting to parse file..")

    case Cache.get_pid(process_id_name) do
      {:ok, nil} ->
        nil

      {:ok, pid} ->
        GenServer.cast(pid, {:parse_csv, file, process_id_name})
    end
  end

  @doc """
  Calling get_report will terminate the process,
  delete its cache/state after a sucessful attempt.
  """
  def get_report(process_id_name) do
    case Cache.get_process_report(process_id_name) do
      {:ok, nil} ->
        {:error, nil}

      {:ok, report} ->
        # Kill process after 3 seconds.
        # Requirement as understood:
        # After downloading the failure result, the user should not be able to download it again.
        case Cache.get_pid(process_id_name) do
          {:ok, nil} ->
            {:error, "Process not found."}

          {:ok, pid} ->
            Process.send_after(pid, {:kill_after, process_id_name}, 3000)
            Logger.info("All data will be wiped out in 3 seconds.")
            {:ok, report.failure_reasons}
        end
    end
  end

  # Server interface
  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:parse_csv, file, process_id}, state) do
    stream = File.stream!(file) |> CSV.decode!(headers: true)
    count = Enum.count(stream)

    for {item, index} <- Enum.with_index(stream) do
      item
      |> Product.from_csv()
      |> Products.create_product()
      |> Cache.update_progress_report(process_id, count - (index + 1))

      # Push update to live_report subscription.
      Absinthe.Subscription.publish(
        OtpCsvParserWeb.Endpoint,
        Cache.get_process_report(process_id),
        live_report: process_id
      )

      # Simulate live updates
      Process.sleep(3000)
    end

    Logger.info("Parsing is done. Server will die in 1 hour.")

    # Kill process 1 hour after parsing is done.
    Process.send_after(self(), {:kill_after, process_id}, @terminate_after)

    {:noreply, state}
  end

  @impl true
  def handle_info({:kill_after, process_id}, _state) do
    Logger.info("Deleting data...")
    Cache.delete_process(process_id)
    exit(:normal)
    {:noreply, []}
  end

  # Local return
  def handle_info(_, _state) do
    {:noreply, []}
  end
end
