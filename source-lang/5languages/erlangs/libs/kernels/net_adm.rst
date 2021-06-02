net_adm模块
###############

.. function:: localhost/0

::

    localhost() -> Name
    类型:
    Name = string()
    返回local host的name.
    返回本地主机的名称。 如果使用命令行标志-name启动Erlang，则Name是完全限定名称
    Returns the name of the local host. If Erlang was started with command-line flag -name, Name is the fully qualified name.


.. function:: name/0/1

::

    names() -> {ok, [{Name, Port}]} | {error, Reason}
    names(Host) -> {ok, [{Name, Port}]} | {error, Reason}
    类型:
    Host = atom() | string() | inet:ip_address()
    Name = string()
    Port = integer() >= 0
    Reason = address | file:posix()

说明::

    Similar to epmd -names, see erts:epmd(1). Host defaults to the local host. Returns the names and associated port numbers of the Erlang nodes that epmd registered at the specified host. Returns {error, address} if epmd is not operational.

.. function:: ping/1

结构::

    ping(Node) -> pong | pang
    Types
    Node = atom()

说明::

    Sets up a connection to Node. Returns pong if it is successful, otherwise pang.




