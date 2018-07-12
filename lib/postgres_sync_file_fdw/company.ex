defmodule PostgresSyncFileFdw.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field(:name, :string)
    field(:external_id, :string)
    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [])
    |> validate_required([])
  end
end
