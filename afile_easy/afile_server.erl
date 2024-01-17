-module(afile_server).
-export([start/1, loop/1]).

% spawn(Module, Name, Args)
start(Dir) -> spawn(afile_server, loop, [Dir]).

loop(Dir) -> 
	% 等待指令
	receive
		% ；是并行的意思
		{Client, list_dir} ->
			Client ! {self(), file:list_dir(Dir)}; % 回复一个文件列表
		{Client, {get_file, File}} ->
			Full = filename:join(Dir, File),
			Client ! {self(), file:read_file(Full)}% 回复这个文件
	end,
	% 自身调用，实现循环。Erlang采用“尾部调用”不会耗尽栈空间
	loop(Dir).
