defmodule TicketSocket do
  use Application

  import Main;

    def start(_type, _args) do
        server=Socket.Web.listen! 8082
        listen server
    end

    def listen(server) do
        client=server |> Socket.Web.accept!
    spawn(
        fn ->
        client |> Socket.Web.accept!
        getMsg(client)
        end
        )
        listen server
    end


    def getMsg(client) do
        case client |> Socket.Web.recv! do
            {:text,data} ->
            IO.puts data
            json_input=data
            {status,list}=JSON.decode(json_input)
            IO.puts status
            if(is_map list) do
                  Main.main(list,client)
                  else
                  IO.puts "非法数据"
            end


            getMsg(client)
        end
    end
    def setMsg(client) do
      client |> Socket.Web.send!(client |> Socket.Web.recv!)
#        client |> Socket.Web.send! ({ :text, "test" })
      getMsg(client)
    end

end