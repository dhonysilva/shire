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

  aggregates do
    count(:total_tickets, :tickets)

    count :open_tickets, :tickets do
      filter(expr(status == :open))
    end

    count :closed_tickets, :tickets do
      filter(expr(status == :closed))
    end
  end

  # We can fetch the percent_open calculation by using the following query:
  # Shire.Support.Representative |> Ash.Query.filter(percent_open > 0.25) |> Ash.Query.sort(:percent_open) |> Ash.Query.load(:percent_open) |> Ash.read!()

  calculations do
    calculate(:percent_open, :float, expr(open_tickets / total_tickets))
  end
end
