历史
####

Docker 最初是 dotCloud 公司创始人 Solomon Hykes 在法国期间发起的一个公司内部项目，它是基于 dotCloud 公司多年云服务技术的一次革新，并于 2013 年 3 月以 Apache 2.0 授权协议开源，主要项目代码在 GitHub 上进行维护。Docker 项目后来还加入了 Linux 基金会，并成立推动 开放容器联盟（OCI）。
在 2013 年底，dotCloud 公司决定改名为 Docker。Docker 最初是在 Ubuntu 12.04 上开发实现的；Red Hat 则从 RHEL 6.5 开始对 Docker 进行支持。

Docker 使用 Google 公司推出的 Go 语言 进行开发实现，基于 Linux 内核的 `cgroup <https://zh.wikipedia.org/wiki/Cgroups>`_，`namespace <https://en.wikipedia.org/wiki/Linux_namespaces>`_，以及 `AUFS <https://en.wikipedia.org/wiki/Aufs>`_ 类的 `Union FS <https://en.wikipedia.org/wiki/Union_mount>`_ 等技术，对进程进行封装隔离，属于 `操作系统层面的虚拟化技术 <https://en.wikipedia.org/wiki/Operating-system-level_virtualization>`_。由于隔离的进程独立于宿主和其它的隔离的进程，因此也称其为容器。最初实现是基于 `LXC <https://linuxcontainers.org/lxc/introduction/>`_，从 0.7 版本以后开始去除 LXC，转而使用自行开发的 `libcontainer <https://github.com/docker/libcontainer>`_，从 1.11 开始，则进一步演进为使用 `runC <https://github.com/opencontainers/runc>`_ 和 `containerd <https://github.com/containerd/containerd>`_

.. image:: /images/dockers/docker_virtualization.png
   :width: 60%


.. image:: /images/dockers/docker_docker.png
   :width: 60%

Docker 分为 CE 和 EE 两大版本。CE 即社区版（免费，支持周期 7 个月），EE 即企业版，强调安全，付费使用，支持周期 24 个月。

Docker CE 分为 stable, test, 和 nightly 三个更新频道。每六个月发布一个 stable 版本 (18.09, 19.03, 19.09...)。



