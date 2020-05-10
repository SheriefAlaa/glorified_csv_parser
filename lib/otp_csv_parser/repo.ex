defmodule OtpCsvParser.Repo do
  use Ecto.Repo,
    otp_app: :otp_csv_parser,
    adapter: Ecto.Adapters.Postgres
end
