securityContext选项
###################

.. note:: 以下实例都是container级别，同样的操作也可以通过「pod.spec.securityContext」属性设置为pid级别。

Running a container as a specific user
======================================

.. literalinclude:: /files/k8s/yamls/option_securityContext_runAsUser.yaml
   :language: yaml

使用::

    $ kubectl exec pod-as-user-guest id
    uid=405(guest) gid=100(users)


Preventing a container from running as root
===========================================

.. literalinclude:: /files/k8s/yamls/option_securityContext_runAsNonRoot.yaml
   :language: yaml

如果使用root用户就会报错::

    $ kubectl get po pod-run-as-non-root
    NAME                    READY     STATUS
    pod-run-as-non-root     0/1       container has runAsNonRoot and image will run as root

Running pods in privileged mode
===============================

.. literalinclude:: /files/k8s/yamls/option_securityContext_privileged.yaml
   :language: yaml

List of available devices in a non-privileged pod::

    $ kubectl exec -it pod-with-defaults ls /dev
    core    null   fd      ptmx
    full     pts    fuse     random
    mqueue   shm    stderr    urandom 
    stdin    zero   stdout    termination-log
    tty

List of available devices in a privileged pod::

    $ kubectl exec -it pod-privileged ls /dev
    autofs              snd                 tty46
    bsg                 sr0                 tty47
    btrfs-control     stderr    core    stdin
    cpu     stdout    cpu_dma_latency     termination-log 
    fd    tty   full  tty0    fuse    tty1    hpet 
    tty10     hwrng     tty11     tty48     tty49 
    tty5    tty50     tty51     tty52     tty53 
    tty54 tty55 ...

.. note:: 结论: 使用privileged选项后可以使用/dev下多个特殊文件，如运行在Raspberry Pi上的Pod上控制LEDs



Adding individual kernel capabilities to a container
====================================================

.. literalinclude:: /files/k8s/yamls/option_securityContext_capabilities.yaml
   :language: yaml

默认不能修改时间::

    $ kubectl exec -it pod-with-defaults -- date +%T -s "12:00:00"
    date: can not set date: Operation not permitted

增加配置add「SYS_TIME」权限后就可以了::

    $ kubectl exec -it pod-add-settime-capability -- date +%T -s "12:00:00"
    12:00:00

Dropping capabilities from a container
======================================

.. literalinclude:: /files/k8s/yamls/option_securityContext_capabilities2.yaml
   :language: yaml

默认有修改文件所有者的权限::

    $ kubectl exec pod-with-defaults chown guest /tmp
    $ kubectl exec pod-with-defaults -- ls -la / | grep tmp 
    drwxrwxrwt 2 guest root 6 May 25 15:18 tmp

增加配置drop「CHOWN」权限后就不可以了::

    $ kubectl exec pod-drop-chown-capability chown guest /tmp
    chown: /tmp: Operation not permitted

Preventing processes from writing to the container’s filesystem
===============================================================

.. literalinclude:: /files/k8s/yamls/option_securityContext_fileSystem.yaml
   :language: yaml

增加配置「readOnlyRootFilesystem」后::

    $ kubectl exec -it pod-with-readonly-filesystem touch /new-file
    touch: /new-file: Read-only file system

但还是可以创建mount的目录::

    $ kubectl exec -it pod-with-readonly-filesystem touch /volume/newfile
    $ kubectl exec -it pod-with-readonly-filesystem -- ls -la /volume/newfile 
    -rw-r--r-- 1 root root 0 May 7 19:11 /mountedVolume/newfile



