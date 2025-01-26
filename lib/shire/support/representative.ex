defmodule Shire.Support.Representative do
  use Ash.Resource, otp_app: :shire, domain: Shire.Support, data_layer: AshPostgres.DataLayer

  postgres do
    table "representatives"
    repo Shire.Repo
  end

  actions do
    defaults([:read])

    create :create do
      accept([:name])
    end
  end

  attributes do
    uuid_primary_key(:id)

    attribute :name, :string do
      public?(true)
    end
  end

  relationships do
    has_many :tickets, Shire.Support.Ticket
    belongs_to :organization, Shire.Accounts.Organization
  end
end
