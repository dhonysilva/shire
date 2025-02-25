defmodule Shire.Support.Ticket do
  use Ash.Resource, otp_app: :shire, domain: Shire.Support, data_layer: AshPostgres.DataLayer

  postgres do
    table "tickets"
    repo Shire.Repo
  end

  actions do
    defaults([:read])

    create :open do
      accept([:subject])
    end

    update :assign do
      accept([:representative_id])
    end

    update :update do
      accept([:subject])
    end

    update :close do
      accept([])

      validate(attribute_does_not_equal(:status, :close)) do
        message("Ticket is already closed")
      end

      change(set_attribute(:status, :close))
    end
  end

  multitenancy do
    strategy(:attribute)
    attribute(:organization_id)
  end

  attributes do
    uuid_primary_key(:id)

    attribute(:subject, :string) do
      allow_nil?(false)
      public?(true)
    end

    attribute(:status, :atom) do
      constraints(one_of: [:open, :close])
      default(:open)
      allow_nil?(false)
    end

    create_timestamp(:inserted_at)
    update_timestamp(:updated_at)
  end

  relationships do
    belongs_to :organization, Shire.Accounts.Organization
    belongs_to :representative, Shire.Support.Representative
  end
end
