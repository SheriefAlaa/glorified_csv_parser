defmodule OtpCsvParser.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, options: "INHERITS (categories)") do
      add :description_ar, :string
      add :description_en, :string
      add :price, :decimal, null: false
      add :listed, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:products, [:name_ar])
    create unique_index(:products, [:name_en])

  end
end
