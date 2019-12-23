defmodule Taspestry.NodeSupervisor do
    use Application
  
    def create_workers(numNodes) do
      list = Enum.to_list(1..numNodes)
  
      children =
        Enum.map(list, fn x ->
        Supervisor.child_spec({Tapestry.Node, []}, id: x, restart: :permanent)
        end)
    
      opts = [strategy: :one_for_one, name: Taspestry.NodeSupervisor]
      Supervisor.start_link(children, opts)

      result = Supervisor.which_children(Taspestry.NodeSupervisor)
      Enum.map(result, fn {_, child, _, _} -> child end)
    end
end