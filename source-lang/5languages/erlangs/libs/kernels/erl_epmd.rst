erl_epmd模块
#################
Erlang interface towards epmd


start_link/0
''''''''''''''''
结构::

  start_link() -> {ok, pid()} | ignore | {error, term()}
  此函数在模块被以erl_distribution supervisor的child加入时被调用

register_node/2/3
''''''''''''''''''''''
结构::

  register_node(Name, Port) -> Result
  register_node(Name, Port, Driver) -> Result
  类型
  Name = string()
  Port = integer() >= 0
  Driver = inet_tcp | inet6_tcp | inet | inet6
  Creation = integer() >= 0
  Result = {ok, Creation} | {error, already_registered} | term()

说明::

  Registers the node with epmd and tells epmd what port will be used for the current node. It returns a creation number. This number is incremented on each register to help with identifying if a node is reconnecting to epmd.

port_please/2/3
'''''''''''''''''''
结构::

  port_please(Name, Host) -> {ok, Port, Version} | noport
  port_please(Name, Host, Timeout) -> {ok, Port, Version} | noport
  Types
  Name = string()
  Host = inet:ip_address()
  Timeout = integer() >= 0 | infinity
  Port = Version = integer() >= 0




Requests the distribution port for the given node of an EPMD instance. Together with the port it returns a distribution protocol version which has been 5 since Erlang/OTP R6.



实例::

  (arne@dunn)1> erl_epmd:names(localhost).
  {ok,[{"arne",40262}]}



