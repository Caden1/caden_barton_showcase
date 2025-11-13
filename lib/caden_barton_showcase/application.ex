defmodule CadenBartonShowcase.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CadenBartonShowcaseWeb.Telemetry,
      CadenBartonShowcase.Repo,
      {DNSCluster, query: Application.get_env(:caden_barton_showcase, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CadenBartonShowcase.PubSub},
      # Start a worker by calling: CadenBartonShowcase.Worker.start_link(arg)
      # {CadenBartonShowcase.Worker, arg},
      # Start to serve requests, typically the last entry
      CadenBartonShowcaseWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CadenBartonShowcase.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CadenBartonShowcaseWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
