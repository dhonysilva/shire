defmodule Shire.Support.Ticket do
  use Ash.Resource, otp_app: :shire, domain: Shire.Support, data_layer: AshPostgres.DataLayer

  postgres do
    table "tickets"
    repo Shire.Repo
  end
end
