defmodule Shire.Repo.Migrations.CreateOrganization do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:organizations, primary_key: false) do
      add :id, :uuid, null: false, default: fragment("gen_random_uuid()"), primary_key: true
      add :name, :text, null: false
      add :domain, :text, null: false
      add :went_live_at, :naive_datetime
      add :email_domains, {:array, :text}, default: []

      add :inserted_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")
    end

    create unique_index(:organizations, [:id, :domain], name: "organizations_unique_domain_index")
  end

  def down do
    drop_if_exists unique_index(:organizations, [:id, :domain],
                     name: "organizations_unique_domain_index"
                   )

    drop table(:organizations)
  end
end
