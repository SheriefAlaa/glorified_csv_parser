defmodule OtpCsvParser.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name_ar, :string, null: false
      add :name_en, :string, null: false

      timestamps()
    end

    create unique_index(:categories, [:name_ar])
    create unique_index(:categories, [:name_en])

  end
end
