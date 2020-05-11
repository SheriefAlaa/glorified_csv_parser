defmodule OtpCsvParser.Cache do
  alias OtpCsvParser.ErrorHelpers

  @cache_bucket :processes

  def create_process_entry(process_id, pid) do
    Cachex.put(@cache_bucket, process_id, pid)
  end

  def create_process_report(process_id, data) do
    Cachex.put(@cache_bucket, process_report_key(process_id), data)
  end

  def get_pid(process_id) do
    Cachex.get(@cache_bucket, process_id)
  end

  def get_process_report(process_id) do
    {:ok, value} = Cachex.get(@cache_bucket, process_report_key(process_id))
    Map.delete(value, value.failure_reasons)
  end

  def delete_process_entry(process_id) do
    Cachex.del(@cache_bucket, process_id)
  end

  def update_progress_report({:ok, _struct}, process_id, remaining_rows) do
    process_id_report = process_report_key(process_id)

    Cachex.transaction!(@cache_bucket, [process_id_report], fn cache ->
      case Cachex.get(cache, process_id_report) do
        {:ok, nil} ->
          nil

        {:ok, report} ->
          Cachex.update(cache, process_id_report, %{
            report
            | success: report.success + 1,
              remaining_rows: remaining_rows
          })
      end
    end)
  end

  def update_progress_report({:error, reason}, process_id, remaining_rows) do
    process_id_report = process_report_key(process_id)

    Cachex.transaction!(@cache_bucket, [process_id_report], fn cache ->
      case Cachex.get(cache, process_id_report) do
        {:ok, nil} ->
          nil

        {:ok, report} ->
          Cachex.update(cache, process_id_report, %{
            report
            | failure: report.failure + 1,
              failure_reasons: report.failure_reasons ++ [ErrorHelpers.transform_errors(reason)],
              remaining_rows: remaining_rows
          })
      end
    end)
  end

  def delete_process(process_id) do
    process_id_report = process_report_key(process_id)
    Cachex.del(@cache_bucket, process_id)
    Cachex.del(@cache_bucket, process_id_report)
  end

  defp process_report_key(process_id), do: process_id <> "-report"
end
