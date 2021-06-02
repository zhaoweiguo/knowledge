介绍
####


Docker是一个开放源代码软件项目，让应用程序部署在软件货柜下的工作可以自动化进行，借此在Linux操作系统上，提供一个额外的软件抽象层，以及操作系统层虚拟化的自动管理机制。

Docker利用Linux核心中的资源分离机制，例如cgroups，以及Linux核心名字空间（namespaces），来创建独立的容器（containers）。这可以在单一Linux实体下运作，避免引导一个虚拟机造成的额外负担。Linux核心对名字空间的支持完全隔离了工作环境中应用程序的视野，包括行程树、网络、用户ID与挂载文件系统，而核心的cgroup提供资源隔离，包括CPU、存储器、block I/O与网络。从0.9版本起，Dockers在使用抽象虚拟是经由libvirt的LXC与systemd - nspawn提供界面的基础上，开始包括libcontainer库做为以自己的方式开始直接使用由Linux核心提供的虚拟化的设施，


namespaces
-------------

cgroups
-----------
cgroups，其名称源自控制组群（control groups）的简写，是Linux内核的一个功能，用来限制、控制与分离一个行程组群的资源（如CPU、内存、磁盘输入输出等）。

这个项目最早是由Google的工程师（主要是Paul Menage和Rohit Seth）在2006年发起，最早的名称为行程容器（process containers）。在2007年时，因为在Linux内核中，容器（container）这个名词有许多不同的意义，为避免混乱，被重命名为cgroup，并且被合并到2.6.24版的内核中去。自那以后，又添加了很多功能。

cgroups的一个设计目标是为不同的应用情况提供统一的接口，从控制单一进程（像nice）到操作系统层虚拟化（像OpenVZ，Linux-VServer，LXC）。cgroups提供：

资源限制：组可以被设置不超过设定的内存限制；这也包括虚拟内存。
优先级：一些组可能会得到大量的CPU 或磁盘IO吞吐量。
结算：用来衡量系统确实把多少资源用到适合的目的上。
控制：冻结组或检查点和重启动。

