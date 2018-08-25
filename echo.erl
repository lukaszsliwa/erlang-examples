-module(echo).

-export([start_server/0, start_client/1, client/2, server/0, start/0]).

server() ->
	receive
		{Message, Client_PID} ->
			io:format("Received ~p~n", [Message]),
			Client_PID ! Message
	end, server().

client(Message, Server) ->
	Server ! {Message, self()},
	io:format("Send message: ~p~n", [Message]),
	receive
		Message -> io:format("Received: ~p~n", [Message])
	end.

start_server() ->
	register(server, spawn(echo, server, [])).

start_client(Node) ->
	spawn(echo, client, ['przykladowy tekst', Node]).

start() ->
	Node = start_server(),
	start_client(Node).
