defmodule Tapestry.Node do
    def start_link(node) do
      {:ok, pid} = GenServer.start_link(__MODULE__, node)
      {:ok, pid}
    end

    def init(args) do
      {:ok, {0},%{}}
    end
end