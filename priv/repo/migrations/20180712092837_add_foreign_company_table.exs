defmodule PostgresSyncFileFdw.Repo.Migrations.AddForeignCompanyTable do
  use Ecto.Migration

  @up ~s"""
    CREATE FOREIGN TABLE external_companies (
      company_id text,
      name text,
      address1 text,
      address2 text,
      city text,
      state text,
      zipcode text,
      country text
    ) SERVER files
    OPTIONS ( filename '/files/Company.csv', format 'csv', delimiter '|', header 'on', quote E'\x01');
  """

  @down ~s"""
    DROP FOREIGN TABLE external_companies;
  """

  def change do
    execute(@up, @down)
  end
end
