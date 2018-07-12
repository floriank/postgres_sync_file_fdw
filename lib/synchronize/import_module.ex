defmodule Synchronize.ImportModule do
  @moduledoc """
  The module supports data synchronization from a source of thruth, allowing
  transformations
  """
  require Logger

  alias PostgresSyncFileFdw.Repo

  @doc """
  Starts the import for a given set of billing addresses
  """
  def sync(source, mapper, importer) do
    Logger.info("Synchronizing...")
    started = System.monotonic_time()

    {:ok, count} = run(source, mapper, importer)

    finished = System.monotonic_time()

    time_spent =
      System.convert_time_unit(finished - started, :native, :milliseconds)

    Logger.info("Synchronized #{count} item(s) in #{time_spent} millisecond(s)")
  end

  @batch_size 2_000

  defp run(source, item_mapper, batch_processor) do
    processor = fn batch ->
      batch_processor.(batch)
      batch
    end

    Repo.transaction(fn ->
      source
      |> stream_row()
      |> Stream.map(item_mapper)
      |> Stream.chunk_every(@batch_size)
      |> Stream.flat_map(processor)
      |> Enum.count()
    end)
  end

  def stream_row(source) when is_list(source) do
    source
  end

  def stream_row(%Ecto.Adapters.SQL.Stream{} = source) do
    Stream.flat_map(source, fn %{rows: rows} -> rows end)
  end
end
