defmodule Ticket do
  use Application

  def start(_type, _args) do
    port = Application.get_env(:example, :cowboy_port, 8081)

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Ticket.Plug.Router, [], port: port)
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end