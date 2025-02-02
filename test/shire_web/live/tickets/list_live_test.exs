defmodule ShireWeb.Tickets.ListLiveTest do
  use ShireWeb.ConnCase
  import Phoenix.LiveViewTest

  alias Shire.Support
  alias Shire.Accounts

  @doc """
  Helper function to navigate to tickets
  """
  def goto_page(conn) do
    live(conn, ~p"/tickets")
  end

  def create_tenant(tenant \\ %{name: "Tenant 1", domain: "tenant_1"}) do
    Accounts.create_organization(tenant)
  end

  def create_tenants(count) do
    Enum.each(1..count, fn count ->
      create_tenant(%{name: "Tenant #{count}", domain: "tenant_#{count}"})
    end)
  end

  def create_ticket(tenant) do
    Support.open_ticket(%{subject: "Ticket 1", tenant: tenant.id})
  end

  describe "List tickets:" do
    test "1) User can visit /tickets and see a dropdown of organizations", %{conn: conn} do
      # 1. Create organizations as tenants
      create_tenants(5)

      # 2. Visit the page
      {:ok, _view, html} = goto_page(conn)

      # 3. Ensure the page is being rendered properly
      assert html =~ "Tickets"
    end

    test "2) User can select an existing organization on the tickets", %{conn: conn} do
      # 1. Create organizations as tenants
      create_tenants(5)

      {:ok, [first_result | _]} = Shire.Accounts.list_organizations()
      create_ticket(first_result)

      # 2. Visit the page
      {:ok, view, html} = goto_page(conn)

      # 3. Ensure organization created are listed in list options
      html =
        view
        |> element("#select-tenant")
        |> render_change(%{tenant: first_result.id})

      # 4. Confirm that the ticket has been created
      # assert html =~ "Ticket 1" ← Todo: research and provide a solution for this test.

      # 5. Confirm that the ticket is listed when a different organization is selected
      html_2 =
        view
        |> element("#select-tenant")
        |> render_change(%{tenant: first_result.id})
    end
  end
end
