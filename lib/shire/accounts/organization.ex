defmodule Shire.Accounts.Organization do
  use Ash.Resource, otp_app: :shire, domain: Shire.Accounts, data_layer: AshPostgres.DataLayer

  postgres do
    table "organizations"
    repo Shire.Repo
  end
end
