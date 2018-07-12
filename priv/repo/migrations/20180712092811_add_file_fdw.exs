defmodule PostgresSyncFileFdw.Repo.Migrations.AddFileFdw do
  use Ecto.Migration

  @up ~s"""
    CREATE EXTENSION file_fdw;
  """

  @down ~s"""
    DROP EXTENSION file_fdw;
  """

  def change do
    execute(@up, @down)
  end
end
