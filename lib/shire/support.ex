defmodule Shire.Support do
  use Ash.Domain,
    otp_app: :shire

  alias Shire.Support.Ticket

  resources do
    resource Ticket do
      define(:open_ticket, action: :open)
      define(:close_ticket, action: :close)
      define(:list_tickets, action: :read)
      define(:update_ticket, action: :update)
    end

    resource(Shire.Support.Representative)
  end
end
