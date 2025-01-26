defmodule Shire.Support.Representative do
  use Ash.Resource, otp_app: :shire, domain: Shire.Support, data_layer: AshPostgres.DataLayer

  postgres do
    table "representatives"
    repo Shire.Repo
  end
end
