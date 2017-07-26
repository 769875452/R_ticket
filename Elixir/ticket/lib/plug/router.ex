defmodule Ticket.Plug.Router do
  use Plug.Router

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]
#  plug VerifyRequest, fields: ["content", "mimetype"],
#                      paths:  ["/upload"]

  plug Check ,paths: ["/check"];
  plug :match
  plug :dispatch

#  get "/", do: send_resp(conn, 200, "Welcome");
  match _, do: send_resp(conn, 404, "access defined!")
end