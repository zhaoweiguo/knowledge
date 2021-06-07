.. _go_tool:

go tool命令
###########

usage::

    $ go tool [-n] command [args...]

    Tool runs the go tool command identified by the arguments.
    With no arguments it prints the list of known tools.

    For more about each tool command, see 'go doc cmd/<command>'.

-n flag::

    print the command that would be executed but not execute it

pprof
=====

::

    $ go tool pprof
    $ go tool pprof -h
    $ go doc cmd/pprof

说明::

    Pprof interprets and displays profiles of Go programs.
    For more information, see https://blog.golang.org/profiling-go-programs

Usage::

    $ go tool pprof binary profile

.. _go_tool_link:

link
====

go tool link::

    -s    disable symbol table
    -w    disable DWARF generation










