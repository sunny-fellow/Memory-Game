defmodule JogoMemoria.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JogoMemoriaWeb.Telemetry,
      JogoMemoria.Repo,
      {DNSCluster, query: Application.get_env(:jogo_memoria, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: JogoMemoria.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: JogoMemoria.Finch},
      # Start a worker by calling: JogoMemoria.Worker.start_link(arg)
      # {JogoMemoria.Worker, arg},
      # Start to serve requests, typically the last entry
      JogoMemoriaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JogoMemoria.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JogoMemoriaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
