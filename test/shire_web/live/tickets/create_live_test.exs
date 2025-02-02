defmodule ShireWeb.Tickets.CreateLivetest do
  use ShireWeb.ConnCase
  import Phoenix.LiveViewTest
  # ← It deserve more atention. To study more.

  describe "Create Ticket" do
    test "User should see open ticket form when visiting /tickets/open", %{conn: conn} do
      # 1. Go to /tickets/open
      {:ok, view, html} = live(conn, ~p"/tickets/open")

      # 2. See the "Open Ticket" text on the page
      assert html =~ "Open Ticket"

      # 3. See the Subject input on the page
      assert html =~ "name=\"form[subject]\""

      # 4. See the Tenant lists on the page
      assert html =~ "name=\"form[tenant]\""

      # 5. See the Submit button on the page
      assert html =~ "Open"
    end

    test "User should see erros while trying to submit invalid data", %{conn: conn} do
      # 1. Create an organization to test with
      {:ok, tenant} = Shire.Accounts.create_organization(%{name: "Tenant 1", domain: "tenand_1"})

      # 2. Go to /tickets/open page
      {:ok, view, _html} = live(conn, ~p"/tickets/open")

      # 3. Submit invalid form
      invalid_form = %{subject: "", tenant: tenant.id}

      html =
        view
        |> form("#ticket-form", form: invalid_form)
        |> render_submit()

      # 4. Expect to see the error message on the page
      assert html =~ "is required"
    end

    test "User should successfully open a ticket with valid data", %{conn: conn} do
      # List here
    end
  end
end
