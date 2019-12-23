defmodule Tapestry.Driver do
    use GenServer

    def start_link({numNodes, numRequests}) do
      {:ok, pid} =
       GenServer.start_link(__MODULE__, {numNodes, numRequests}, name: __MODULE__)
       GenServer.cast(pid,{:start,{numNodes,numRequests}})

       {:ok, pid}
    end

    def handle_cast({:start,{numNodes,numRequests}}, _state) do
      nodes = Taspestry.NodeSupervisor.create_workers(numNodes)
      
      nodes_to_string = Enum.each(nodes, fn x -> inspect x end)
      hash_nodes = Enum.each(nodes_to_string, fn x -> :crypto.hash(:sha256, x) end) #|> Base.encode16
      IO.inspect hash_nodes

    end
    def init(init_arg) do
      {:ok, init_arg}
    end
end