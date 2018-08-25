-module (sendfile).
-export ([start_send/1, start_recv/0, send/1, recv/0]).

send (To) ->
	{ok, File} = file:read_file('./send'), {sendfile_proc, To} ! File.

recv () ->
	receive
		File -> file:write_file('./recv', File)
	end.

start_send(To) ->
	spawn(sendfile, send, [To]).

start_recv() ->
	register(sendfile_proc, spawn(sendfile, recv, [])).

