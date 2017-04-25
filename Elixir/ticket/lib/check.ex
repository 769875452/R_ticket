defmodule Check do

  import Plug.Conn
  import CheckLastNum;
  import CheckParagraphNumsCount;
  import ContinumCheck;
  import EvenLength;
  import OddLength;
  import SumCheck;

  def init(options), do: options

  def call(%Plug.Conn{request_path: path} = conn, opts) do
    if path in opts[:paths] do
        check(conn)
    end
    conn
  end
  defp check(conn) do
  query_params=conn.query_params;



  test=query_params["test"]



  conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, test)
  end
end