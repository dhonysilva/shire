defmodule Shire.Support do
  use Ash.Domain,
    otp_app: :shire

  alias Shire.Support.Ticket

  resources do
    resource Ticket do
      define(:open_ticket, action: :open)
      define(:list_tickets, action: :read)
    end
  end
end
