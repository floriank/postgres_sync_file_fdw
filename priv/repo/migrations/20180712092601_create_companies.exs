defmodule PostgresSyncFileFdw.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add(:name, :string, null: false)
      add(:external_id, :string, null: false)

      timestamps()
    end

    create(unique_index(:companies, :external_id))
  end
end
