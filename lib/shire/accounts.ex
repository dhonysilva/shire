defmodule Shire.Accounts do
  use Ash.Domain,
    otp_app: :shire

  alias Shire.Accounts.Organization

  resources do
    resource Organization do
      define(:create_organization, action: :create)
      define(:list_organizations, action: :read)
    end
  end
end
