defmodule ShireWeb.Tickets.ListLive do
  use ShireWeb, :live_view
  alias Shire.Accounts
  alias Shire.Support

  def render(assigns) do
    ~H"""
    <.header>Tickets</.header>

    <%!-- Button to take the user to a new ticket page --%>
    <.button phx-click={JS.navigate(~p"/tickets/open")}>Open a ticket</.button>

    <%!-- Form to select tenant the user wants to display tickets for --%>
    <.simple_form for={@form} id="select-tenant-form">
      <.input
        name="tenant"
        id="select-tenant"
        type="select"
        label="Select Tenant"
        value=""
        prompt="Select Organisation"
        phx-change="select-tenant"
        options={Enum.map(@organizations, fn tenant -> {tenant.name, tenant.id} end)}
      />
    </.simple_form>

    <%!-- List tickets based on the selected tenant --%>
    <.list>
      <pre><%= inspect assigns.tenant, pretty: true %></pre>
      <:item :for={ticket <- @tickets} title={ticket.subject}>
        {ticket.status}
        <.button id="close-ticket" phx-click="close-ticket" phx-value-id={ticket.id}>
          Close Ticket
        </.button>
      </:item>
    </.list>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, organizations} = Accounts.list_organizations()

    socket =
      socket
      |> assign(:organizations, organizations)
      |> assign(:form, to_form(%{}))
      |> assign(:tickets, [])

    {:ok, socket}
  end

  def handle_event("select-tenant", %{"tenant" => tenant}, socket) do
    {:ok, tickets} = Support.list_tickets(tenant: tenant)

    socket =
      socket
      |> assign(:tickets, tickets)
      |> assign(:tenat, tenant)

    {:noreply, socket}
  end

  def handle_event("close-ticket", %{"id" => ticket_id}, socket) do
    tenant = socket.assigns.tenat

    case Support.close_ticket(ticket_id, tenant: tenant) do
      {:ok, ticket} ->
        socket = put_flash(socket, :info, "Ticket no. #{ticket.id} closed.")
        {:noreply, socket}

      {:error, form} ->
        socket =
          socket
          |> assign(:form, form)
          |> put_flash(:error, "Unable to close the ticket.")

        {:noreply, socket}
    end
  end
end
