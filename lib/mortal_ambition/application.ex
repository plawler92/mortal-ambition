defmodule MortalAmbition.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MortalAmbitionWeb.Telemetry,
      MortalAmbition.Repo,
      {DNSCluster, query: Application.get_env(:mortal_ambition, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MortalAmbition.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MortalAmbition.Finch},
      # Start a worker by calling: MortalAmbition.Worker.start_link(arg)
      # {MortalAmbition.Worker, arg},
      # Start to serve requests, typically the last entry
      MortalAmbitionWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MortalAmbition.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MortalAmbitionWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
