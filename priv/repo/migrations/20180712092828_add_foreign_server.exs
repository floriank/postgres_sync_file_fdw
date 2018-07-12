defmodule PostgresSyncFileFdw.Repo.Migrations.AddForeignServer do
  use Ecto.Migration

  @up ~s"""
    CREATE SERVER files FOREIGN DATA WRAPPER file_fdw;
  """

  @down ~s"""
    DROP SERVER files;
  """

  def change do
    execute(@up, @down)
  end
end
