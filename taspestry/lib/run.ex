defmodule Tapestry.Runner do
    def start(numNodes, numRequests) do
        children = [
        Supervisor.child_spec({Tapestry.Driver, {numNodes, numRequests}},
            id: numNodes,
            restart: :permanent
        )
        ]

        # See https://hexdocs.pm/elixir/Supervisor.html
        # for other strategies and supported options
        opts = [strategy: :one_for_one, name: Tapestry.Supervisor]
        Supervisor.start_link(children, opts)
    end

    def main() do
      cli_args = System.argv()
      main(cli_args)
    end

    def main(cli_args) do
      numNodes = String.to_integer(Enum.at(cli_args,0))
      numRequests = String.to_integer(Enum.at(cli_args,1))
    end
end