defmodule ShireWeb.Tickets.CreateLive do
  use ShireWeb, :live_view
  alias AshPhoenix.Form
  alias Shire.Accounts
  alias Shire.Support.Ticket

  def render(assigns) do
    ~H"""
    <.header>Open Ticket</.header>
    <.simple_form for={@form} phx-submit="save" phx-change="validate" id="ticket-form">
      <.input field={@form[:subject]} label="New Ticket Subject" />
      <.input
        field={@form[:tenant]}
        type="select"
        label="Select Tenant"
        options={Enum.map(@organizations, fn tenant -> {tenant.name, tenant.domain} end)}
      />
      <:actions>
        <.button>Open</.button>
      </:actions>
    </.simple_form>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, organizations} = Accounts.list_organizations()
    form = Form.for_create(Ticket, :open) |> to_form()

    socket =
      socket
      |> assign(:form, form)
      |> assign(:organizations, organizations)

    {:ok, socket}
  end

  def handle_event("validate", %{"form" => form_attrs}, socket) do
    form = Form.validate(socket.assigns.form, form_attrs)
    {:noreply, assign(socket, :form, form)}
  end

  def handle_event("save", %{"form" => form_attrs}, socket) do
    %{"tenant" => tenant} = form_attrs

    form = Form.for_create(Ticket, :open, tenant: tenant) |> to_form()

    case Form.submit(form, params: form_attrs) do
      {:ok, _item} ->
        {:noprely, put_flash(socket, :info, "Ticket opened")}

      {:error, form} ->
        {:noreply, assign(socket, :form, form)}
    end
  end
end
