defmodule Shire.Accounts do
  use Ash.Domain,
    otp_app: :shire

  resources do
    resource(Shire.Accounts.Organization)
  end
end
