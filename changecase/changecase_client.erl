-module(changecase_client).
-export([changecase_client/3]).

changecase_client(Server, Str, Command) ->
	Server ! {self(), {Str, Command}},
	receive
		{Server, ResultString} ->
			ResultString
	end.
