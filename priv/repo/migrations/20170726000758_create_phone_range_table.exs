defmodule Repo.Migrations.CreatePhoneRangeTable do
  use Ecto.Migration

  def change do
    create table(:phone_range) do
      add :start_phone, :string, size: 15
      add :end_phone, :string, size: 15
      add :parent_phone_range_id, references(:phone_range, [on_delete: :delete_all]) 
    end
    create index(:phone_range, :parent_phone_range_id)
  end
end
