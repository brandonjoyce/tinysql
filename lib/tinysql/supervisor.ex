defmodule Tinysql.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      worker(Tinysql.Repo, []),
      Plug.Adapters.Cowboy.child_spec(:http, Tinysql.Router, [], [port: 4000])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
