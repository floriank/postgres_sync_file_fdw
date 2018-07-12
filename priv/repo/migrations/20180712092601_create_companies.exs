defmodule PostgresSyncFileFdw.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add(:name, :string, null: false)
      add(:company_id, :integer, null: false)

      timestamps()
    end
  end
end
