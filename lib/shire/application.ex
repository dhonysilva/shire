defmodule Shire.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ShireWeb.Telemetry,
      Shire.Repo,
      {DNSCluster, query: Application.get_env(:shire, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Shire.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Shire.Finch},
      # Start a worker by calling: Shire.Worker.start_link(arg)
      # {Shire.Worker, arg},
      # Start to serve requests, typically the last entry
      ShireWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Shire.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ShireWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
