tcpcopy命令 [1]_
=======================
:待实践:


架构图:

.. figure:: /images/linuxs/linux_command_tcpcopy_architecture.png
   :width: 70%

前提::

  1. Assume 61.135.233.161 is the IP address of the assistant server


On the target server which runs server applications::

     //Assume 61.135.233.161 is the IP address of the assistant server. We set the 
     //following route command to route all responses to the 62.135.200.x's clients 
     //to the assistant server.

     route add -net 62.135.200.0 netmask 255.255.255.0 gw 65.135.233.161

On the assistant server which runs intercept(root privilege is required)::

       ./intercept -F <filter> -i <device,>
       // intercept will capture response packets of the TCP based application which listens
       // on port 8080 from device eth0
       ./intercept -i eth0 -F 'tcp and src port 8080' -d


On the online source server (root privilege is required)::

      ./tcpcopy -x localServerPort-targetServerIP:targetServerPort -s <intercept server,> [-c <ip range,>]
      //tcpcopy would capture port '80' packets on current server, change client IP address 
      //to one of 62.135.200.x series, send these packets to the target port '8080' of the 
      //target server '61.135.233.160', and connect 61.135.233.161 for asking intercept to 
      //pass response packets to it.
      ./tcpcopy -x 80-61.135.233.160:8080 -s 61.135.233.161 -c 62.135.200.x


.. [1] https://github.com/session-replay-tools/tcpcopy

