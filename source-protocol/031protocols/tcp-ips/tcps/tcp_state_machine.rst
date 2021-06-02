TCP状态
#######


.. figure:: /images/protocols/tcp_flow.png
   :width: 80%

   TCP 的整体流程

说明::

    连接阶段: 3次握手
      维护一定的数据结构和对方的信息，确认了该信息：
        我发的内容对方会接收，对方发的内容我也会接收，直到连接断开
    断开阶段: 4次挥手
      确保双方都知道且同意对方断开连接，然后在 remove 为对方维护的数据结构和信息
      对方之后发送的包也不会接收，直到再次连接

    保证连接的原因是有心跳包

TCP 建立连接
============


.. figure:: /images/protocols/tcp_connect.png

   TCP连接建立的过程（三次握手）

.. figure:: /images/protocols/tcp_protocol8.png
   :width: 70%

TCP的建立::

  如上图,可以简单的称为三次握手:
  首先,客户端向服务器申请打开某一个端口(用SYN段等于1的TCP报文)
  然后,服务器端发回一个ACK报文通知客户端请求报文收到
  客户端收到确认报文以后再次发出确认报文,确认刚才服务器端发出的确认报文

  如果再加上TCP的超时重传机制，那么TCP就完全可以保证一个数据包被送到目的地


TCP 断开连接
============

.. figure:: /images/protocols/tcp_disconnect.png

   TCP连接断开的过程（四次挥手）



.. figure:: /images/protocols/tcp_protocol9.png
   :width: 70%

TCP的终止::

  建立一个连接需要三次握手,而终止一个连接要经过4次握手,这是由TCP的半关闭（half close）造成的
  既然一个 TCP连接是全双工（即数据在两个方向上能同时传递）,因此每个方向必须单独地进行关闭
  这原则就是当一方完成它的数据发送任务后就能发送一个 FIN来终止这个方向连接
  当一端收到一个 FIN，它必须通知应用层另一端几经终止了那个方向的数据传送

  客户机给服务器一个FIN为1的TCP报文，然后服务器返回给客户端一个确认ACK报文
  并且发送一个FIN报文，当客户机回复ACK报文后（四次握手），连接就结束了



和服务器的通信结束后，套接字并不会立即被删除，而是等待一段时间之后再被删除原因::

    断开的操作顺序如下:
    1. 客户端发送 FIN 
    2. 服务器返回 ACK 号 
    3. 服务器发送 FIN 
    4. 客户端返回 ACK 号

    如果最后客户端返回的 ACK 号丢失了，结果会如何呢:
      服务 器没有接收到 ACK 号，可能会重发一次 FIN
      客户端的套接字已 经删除了，对应的端口号就会被释放出来
      别的应用程序新创建的套接字，碰巧又被分配了同一个端口号
      这时，服务器重发的 FIN 正好到达，新套接字就开始执行断开操作

    注: 一般来说会等待几分钟之后再删除套接字





TCP 状态迁移路线图
==================


TCP状态迁移路线图:

.. figure:: /images/protocols/tcp_handshake1.png
    :width: 80%



.. figure:: /images/protocols/tcp_state_machine.png

   TCP 状态机



TCP各状态详解
=============

.. option:: LISTENING

    侦听来自远方的TCP端口的连接请求. 
    有提供某种服务才会处于LISTENING状态，TCP状态变化就是某个端口的状态变化，提供一个服务就打开一个端口
    看LISTENING状态最主要的是看本机开了哪些端口，这些端口都是哪个程序开的，关闭不必要的端口是保证安全的一个非常重要的方面

.. option:: SYN-SENT

    客户端SYN_SENT状态
    client发送连接请求后等待匹配的连接请求
    客户端通过应用程序调用connect进行active open.
    于是客户端tcp发送一个SYN以请求建立一个连接.之后状态置为SYN_SENT
    The socket is actively attempting to establish a connection.
    正常情况下SYN_SENT状态非常短暂

.. option:: SYN-RECEIVED

    服务器端状态SYN_RCVD
    服务器收到客户端发送的同步信号时,将标志位ACK和SYN置1发送给客户端,此时服务器端处于SYN_RCVD状态
    如果连接成功了就变为ESTABLISHED
    正常情况下SYN_RCVD状态非常短暂
    如果发现有很多SYN_RCVD状态，那你的机器有可能被SYN Flood的DoS(拒绝服务攻击)攻击了

  SYN Flood的攻击原理是::

    在进行三次握手时，攻击软件向被攻击的服务器发送SYN连接请求（握手的第一步），但是这个地址是伪造的，如攻击软件随机伪造了51.133.163.104、65.158.99.152等等地址。服务器在收到连接请求时将标志位ACK和SYN置1发送给客户端（握手的第二步），但是这些客户端的IP地址都是伪造的，服务器根本找不到客户机，也就是说握手的第三步不可能完成。
    这种情况下服务器端一般会重试（再次发送SYN+ACK给客户端）并等待一段时间后丢弃这个未完成的连接，这段时间的长度我们称为SYN Timeout，一般来说这个时间是分钟的数量级（大约为30秒-2分钟）；一个用户出现异常导致服务器的一个线程等待1分钟并不是什么很大的问题，但如果有一个恶意的攻击者大量模拟这种情况，服务器端将为了维护一个非常大的半连接列表而消耗非常多的资源----数以万计的半连接，即使是简单的保存并遍历也会消耗非常多的CPU时间和内存，何况还要不断对这个列表中的IP进行SYN+ACK的重试。此时从正常客户的角度看来，服务器失去响应，这种情况我们称做：服务器端受到了SYN Flood攻击（SYN洪水攻击）


.. option:: ESTABLISHED

::

    代表一个打开的连接
    ESTABLISHED状态是表示两台机器正在传输数据
    netstat -nat |grep 9502或者使用lsof  -i:9502可以检测到

.. option:: FIN-WAIT-1

::

    等待远程TCP连接中断请求，或先前的连接中断请求的确认
    主动关闭(active close)端应用程序调用close,于是其TCP发出FIN请求主动关闭连接,之后进入FIN_WAIT1状态
    /* The socket is closed, and the connection is shutting down. 等待远程TCP的连接中断请求，或先前的连接中断请求的确认 */
    如果服务器出现shutdown再重启，使用netstat -nat查看，就会看到很多FIN-WAIT-1的状态
    就是因为服务器当前有很多客户端连接，直接关闭服务器后，无法接收到客户端的ACK

.. option:: FIN-WAIT-2

::

    从远程TCP等待连接中断请求
    主动关闭端接到ACK后，就进入了FIN-WAIT-2 .
    /* Connection is closed, and the socket is waiting for a shutdown from the remote end. 从远程TCP等待连接中断请求 */
    这就是著名的半关闭的状态了，这是在关闭连接时，客户端和服务器两次握手之后的状态
    在这个状态下，应用程序还有接受数据的能力，但是已经无法发送数据
    但是也有一种可能是，客户端一直处于FIN_WAIT_2状态
    而服务器则一直处于WAIT_CLOSE状态，而直到应用层来决定关闭这个状态

.. option:: CLOSE-WAIT

::

    等待从本地用户发来的连接中断请求
    被动关闭(passive close)端TCP接到FIN后，就发出ACK以回应FIN请求(它的接收也作为文件结束符传递给上层应用程序),并进入CLOSE_WAIT. 
    /* The remote end has shut down, waiting for the socket to close. 等待从本地用户发来的连接中断请求 */

.. option:: CLOSING

::

    等待远程TCP对连接中断的确认
    比较少见.
    /* Both sockets are shut down but we still don't have all our data sent. 等待远程TCP对连接中断的确认 */

.. option:: LAST-ACK

::

    等待原来的发向远程TCP的连接中断请求的确认
    被动关闭端一段时间后，接收到文件结束符的应用程序将调用CLOSE关闭连接
    这导致它的TCP也发送一个 FIN,等待对方的ACK.就进入了LAST-ACK . 
    /* The remote end has shut down, and the socket is closed. Waiting for acknowledgement. 等待原来发向远程TCP的连接中断请求的确认 */
    使用并发压力测试的时候，突然断开压力测试客户端，服务器会看到很多LAST-ACK

.. option:: TIME-WAIT

::

    等待足够的时间以确保远程TCP接收到连接中断请求的确认
  在主动关闭端接收到FIN后，TCP就发送ACK包，并进入TIME-WAIT状态。/* The socket is waiting after close to handle packets still in the network.等待足够的时间以确保远程TCP接收到连接中断请求的确认 */
     TIME_WAIT等待状态，这个状态又叫做2MSL状态，说的是在TIME_WAIT2发送了最后一个ACK数据报以后，要进入TIME_WAIT状态，这个状态是防止最后一次握手的数据报没有传送到对方那里而准备的（注意这不是四次握手，这是第四次握手的保险状态）。这个状态在很大程度上保证了双方都可以正常结束，但是，问题也来了
    由于插口的2MSL状态（插口是IP和端口对的意思，socket），使得应用程序在2MSL时间内是无法再次使用同一个插口的，对于客户程序还好一些，但是对于服务程序，例如httpd，它总是要使用同一个端口来进行服务，而在2MSL时间内，启动httpd就会出现错误（插口被使用）。为了避免这个错误，服务器给出了一个平静时间的概念，这是说在2MSL时间内，虽然可以重新启动服务器，但是这个服务器还是要平静的等待2MSL时间的过去才能进行下一次连接

.. option:: CLOSED

::

    没有任何连接状态
    被动关闭端在接受到ACK包后，就进入了closed的状态。连接结束.
    /* The socket is not being used. 没有任何连接状态 */


命令查看TCP状态
===============

linux查看tcp的状态命令::

    1）netstat -nat  查看TCP各个状态的数量
    2）lsof  -i:port  可以检测到打开套接字的状况
    3) sar -n SOCK 查看tcp创建的连接数
    4) tcpdump -iany tcp port 9000 对tcp端口为9000的进行抓包

网络测试常用命令::

    1）ping:检测网络连接的正常与否,主要是测试延时、抖动、丢包率
    2）traceroute：raceroute 跟踪数据包到达网络主机所经过的路由工具
    3）pathping：是一个路由跟踪工具
        它将 ping 和 tracert 命令的功能与这两个工具所不提供的其他信息结合起来
    4）mtr：以结合ping nslookup tracert 来判断网络的相关特性
    5) nslookup:用于解析域名，一般用来检测本机的DNS设置是否配置正确








