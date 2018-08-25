-module (echos).
-export ([start_server/0, start_client/2, client/2, server/0]).

server () ->
  receive
    {ClientPID,X} -> io:format("Serwer dostal i odeslal: ~p ~n", [X]), ClientPID ! X
  end, server().

client (Node, Message) ->
  { server_proc, Node } ! { self(), Message },
  receive
    X -> io:format("Klient otrzymal: ~p ~n", [X])
  end.

start_server () ->
  register(server_proc, spawn (echos, server, [])).

start_client (Node, Message) ->
  spawn (echos, client, [Node, Message]).

