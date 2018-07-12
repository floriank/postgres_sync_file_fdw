defmodule Synchronize.SqlModule do
  @moduledoc """
  The module will upsert given companies in batches into the services database.
  """

  alias PostgresSyncFileFdw.{Company, Repo}
  alias Synchronize.ImportModule

  alias Ecto.Adapters.SQL

  @doc """
  the main entrypoint for this module
  """
  def sync do
    find_companies() |> run()
  end

  @doc """
  Starts the import for a given set of companies
  """
  def run(companies) do
    ImportModule.sync(companies, &map/1, &import_batch/1)
  end

  @doc """
  Find missing companies in the services database
  """
  def find_companies do
    SQL.stream(Repo, """
    SELECT external.company_id, external.name
      FROM external_companies external

    LEFT JOIN companies
      -- ignore whitespace from the files
      ON MD5(CONCAT(external.company_id, TRIM(external.name)))
      = MD5(CONCAT(companies.external_id, TRIM(companies.name)))
    WHERE companies.external_id IS NULL
    """)
  end

  defp map([external_id, name]) do
    now = DateTime.utc_now()

    %{
      # name trimming, as the CSV contains whitespace
      name: String.trim(name),
      external_id: external_id,
      inserted_at: now,
      updated_at: now
    }
  end

  defp import_batch(batch) do
    Repo.insert_all(
      Company,
      batch,
      on_conflict: :replace_all,
      conflict_target: :external_id
    )
  end
end
