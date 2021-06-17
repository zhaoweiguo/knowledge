Emqtt其他配置信息
===========================


EMQ Node and Cookie::

  ## Node name
  ## The name cannot be changed after node joined the cluster.
  node.name = emqttd@127.0.0.1

  ## Cookie for distributed node
  node.cookie = emq_dist_cookie


Erlang Distributed Protocol
''''''''''''''''''''''''''''''''
EMQ 节点基于 Erlang/OTP 平台的 TCPv4, TCPv6 或 TLS 协议连接
::

  ## Value: Enum
  ##  - inet_tcp: the default; handles TCP streams with IPv4 addressing.
  ##  - inet6_tcp: handles TCP with IPv6 addressing.
  ##  - inet_tls: using TLS for Erlang Distribution.
  ##
  ## vm.args: -proto_dist inet_tcp
  node.proto_dist = inet_tcp

  ## Specify SSL Options in the file if using SSL for Erlang Distribution.
  ##
  ## Value: File
  ##
  ## vm.args: -ssl_dist_optfile <File>
  ## node.ssl_dist_optfile = {{ platform_etc_dir }}/ssl_dist.conf

