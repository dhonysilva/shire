defmodule Shire.Accounts.Organization do
  use Ash.Resource, otp_app: :shire, domain: Shire.Accounts, data_layer: AshPostgres.DataLayer

  # Per described here https://hexdocs.pm/ash/multitenancy.html#possible-values-for-tenant
  defimpl Ash.ToTenant do
    def to_tenant(%{domain: _domain, id: id}, resource) do
      if Ash.Resource.Info.data_layer(resource) == AshPostgres.DataLayer &&
           Ash.Resource.Info.multitenancy_strategy(resource) == :context do
        "org_#{id}"
      else
        id
      end
    end
  end

  multitenancy do
    strategy(:attribute)
    attribute(:id)
    global?(true)
  end

  postgres do
    table "organizations"
    repo Shire.Repo
  end

  actions do
    defaults([:read, :destroy])

    create :create do
      accept([:name, :domain])
    end

    update :update do
      accept([:name])
    end

    read :by_id do
      argument(:id, :string, allow_nil?: false)
      get?(true)
      filter(expr(id == ^arg(:id)))
    end

    read :by_domain do
      argument(:domain, :string, allow_nil?: false)
      get?(true)
      filter(expr(domain == ^arg(:domain)))
    end
  end

  attributes do
    uuid_primary_key(:id)
    attribute(:name, :string, allow_nil?: false)
    attribute(:domain, :string, allow_nil?: false)
    attribute(:went_live_at, :naive_datetime, allow_nil?: true)
    attribute(:email_domains, {:array, :string}, default: [])
    create_timestamp(:inserted_at)
    update_timestamp(:updated_at)
  end

  identities do
    identity(:unique_domain, [:domain])
  end
end
