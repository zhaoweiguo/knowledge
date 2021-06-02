epmd
#######
Erlang Port Mapper Daemon


启动port mapper daemon
''''''''''''''''''''''''''
::

  epmd [-d|-debug] [DbgExtra...] [-address Addresses] [-port No] [-daemon] [-relaxed_command_check]


Regular Options::

  -address List: 指定epmd实例监听ip地址列表;ip地址用「,」分隔;同环境变量ERL_EPMD_ADDRESS
  -port No: 指定epmd实例监听的端口(默认4369),同ERL_EPMD_PORT
  -d | -debug: 
  -daemon: 默认启动
  -relaxed_command_check: 环境变量ERL_EPMD_RELAXED_COMMAND_CHECK

DbgExtra Options(调试专用)::

  -packet_timeout Seconds: 设定连接不活跃的秒数,如超过epmd超时并关闭连接，默认60
  -delay_accept Seconds:用于模拟busy server环境
  -delay_write Seconds:也用于模拟busy server环境



与一个运行的port mapper daemon交互
'''''''''''''''''''''''''''''''''''''
::

  epmd [-d|-debug] [-port No] [-names|-kill|-stop Name]

选项::

  -names: Lists names registered with the currently running epmd.
  -kill: Kills the currently running epmd.
  -stop Name: Forcibly unregisters a live node from the epmd database.












