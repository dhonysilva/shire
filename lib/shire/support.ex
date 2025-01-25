defmodule Shire.Support do
  use Ash.Domain,
    otp_app: :shire

  resources do
    resource(Shire.Support.Ticket)
  end
end
