docker run
###############

Usage::

    # 在一新的container中运行一新的命令
    docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

常用命令::

    -p, --publish list  将容器端口映射为宿主机端口
    -P, --publish-all   将所有exposed的端口映射为宿主机上的随机端口
    -d, --detach        后台运行
    --name string       为container赋值名
    -u, --user string   指定用户

    -i: --interactive
    -t: --tty
    -v, --volume list   Bind mount a volume, 例: -v <host volume>:<container volume>
    -w, --workdir string   Working directory inside the container

常用实例::

    # 执行docker命令
    $ docker run ubuntu:14.04 /bin/cat /etc/issue

    // -p, --publish list
    # 1. 将容器内的80端口绑定到本地宿主机的80端口上
    $ docker run -d -p 127.0.0.1:80:80 --name static_web test/static_web nginx -g "daemon off;"
    # 2. udp模式
    $ sudo docker run -d -p 127.0.0.1:5000:5000/udp training/webapp python app.py
    # 3. 可以使用类似的方法将容器内的80端口绑定到一个特定网络接口的随机端口上:
    # docker run -d -p 127.0.0.1::80 --name static_web test/static_web nginx -g "daemon off;"
    # 4. 容器启动绑定多IP
    $ docker run -d -p 5005:5000 -p 5006:80 myfirstapp python app.py   #容器ID:44e703c1279a
    $ docker port 44e703c1279a
    5000/tcp -> 0.0.0.0:5005
    80/tcp -> 0.0.0.0:5006

    // -P, --publish-all
    # 该命令会将容器内的80端口对本地宿主机公开，并且绑定到宿主机的一个随机端口上
    $ docker run -d -P --name static_web test/static_web nginx -g "daemon off;"


    // -i: --interactive
    // -t: --tty
    # 需要在运行时指定: --name jenkins-tutorials
    $ docker exec -it jenkins-tutorials bash
    $ docker run -t -i ubuntu:14.04 /bin/bash   # shell登陆 -t(--tty=true) and -i(--interactive=true)

    // --link list
    # 创建一个名为web的container链接到名为db的container
    # --link <name>:<alias>:
    #     <name>:  为要被链接的container的name
    #     <alias>: 是这个<name>的别名
    $ docker run -d -P --name web --link db:db training/webapp python app.py

    // -v, --volume list
    # list是指: -v可以被多次使用
    $ docker run -d -P --name web -v /webapp training/webapp python app.py
    $ docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins
    # Mount a Host Directory as a Data Volume
    $ docker run -d -P --name web -v /src/webapp:/opt/webapp training/webapp python app.py
    # 新建一个read-only类型的volume:
    $ docker run -d -P --name web -v /src/webapp:/opt/webapp:ro training/webapp python app.py

    // -d, --detach
    $ docker run -d ubuntu:14.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"
    1e5535038e285177d5214659a068137486f96ee5c2e85a4ac52dc83f2ebe4147


指定dns::

    -h HOSTNAME 或者 --hostname=HOSTNAME 设定容器的主机名，它会被写到容器内的 /etc/hostname 和 /etc/hosts
    --dns=IP_ADDRESS 添加 DNS 服务器到容器的 /etc/resolv.conf 中
    --dns-search=DOMAIN 设定容器的搜索域，当设定搜索域为 .example.com 时，
        在搜索一个名为 host 的主机时，DNS 不仅搜索 host，还会搜索 host.example.com



Options::

        --add-host list                  Add a custom host-to-IP mapping (host:ip)
    -a, --attach list                    Attach to STDIN, STDOUT or STDERR
        --blkio-weight uint16            Block IO (relative weight), between 10 and 1000, or 0 to disable (default 0)
        --blkio-weight-device list       Block IO weight (relative device weight) (default [])
        --cap-add list                   Add Linux capabilities
        --cap-drop list                  Drop Linux capabilities
        --cgroup-parent string           Optional parent cgroup for the container
        --cidfile string                 Write the container ID to the file
        --cpu-period int                 Limit CPU CFS (Completely Fair Scheduler) period
        --cpu-quota int                  Limit CPU CFS (Completely Fair Scheduler) quota
        --cpu-rt-period int              Limit CPU real-time period in microseconds
        --cpu-rt-runtime int             Limit CPU real-time runtime in microseconds
    -c, --cpu-shares int                 CPU shares (relative weight)
        --cpus decimal                   Number of CPUs
        --cpuset-cpus string             CPUs in which to allow execution (0-3, 0,1)
        --cpuset-mems string             MEMs in which to allow execution (0-3, 0,1)
    -d, --detach                         Run container in background and print container ID
        --detach-keys string             Override the key sequence for detaching a container
        --device list                    Add a host device to the container
        --device-cgroup-rule list        Add a rule to the cgroup allowed devices list
        --device-read-bps list           Limit read rate (bytes per second) from a device (default [])
        --device-read-iops list          Limit read rate (IO per second) from a device (default [])
        --device-write-bps list          Limit write rate (bytes per second) to a device (default [])
        --device-write-iops list         Limit write rate (IO per second) to a device (default [])
        --disable-content-trust          Skip image verification (default true)
        --dns list                       Set custom DNS servers
        --dns-option list                Set DNS options
        --dns-search list                Set custom DNS search domains
        --entrypoint string              Overwrite the default ENTRYPOINT of the image
    -e, --env list                       Set environment variables
        --env-file list                  Read in a file of environment variables
        --expose list                    Expose a port or a range of ports
        --group-add list                 Add additional groups to join
        --health-cmd string              Command to run to check health
        --health-interval duration       Time between running the check (ms|s|m|h) (default 0s)
        --health-retries int             Consecutive failures needed to report unhealthy
        --health-start-period duration   Start period for the container to initialize before starting health-retries
                                         countdown (ms|s|m|h) (default 0s)
        --health-timeout duration        Maximum time to allow one check to run (ms|s|m|h) (default 0s)
        --help                           Print usage
    -h, --hostname string                Container host name
        --init                           Run an init inside the container that forwards signals and reaps processes
    -i, --interactive                    Keep STDIN open even if not attached
        --ip string                      IPv4 address (e.g., 172.30.100.104)
        --ip6 string                     IPv6 address (e.g., 2001:db8::33)
        --ipc string                     IPC mode to use
        --isolation string               Container isolation technology
        --kernel-memory bytes            Kernel memory limit
    -l, --label list                     Set meta data on a container
        --label-file list                Read in a line delimited file of labels
        --link list                      Add link to another container
        --link-local-ip list             Container IPv4/IPv6 link-local addresses
        --log-driver string              Logging driver for the container
        --log-opt list                   Log driver options
        --mac-address string             Container MAC address (e.g., 92:d0:c6:0a:29:33)
    -m, --memory bytes                   Memory limit
        --memory-reservation bytes       Memory soft limit
        --memory-swap bytes              Swap limit equal to memory plus swap: '-1' to enable unlimited swap
        --memory-swappiness int          Tune container memory swappiness (0 to 100) (default -1)
        --mount mount                    Attach a filesystem mount to the container
        --name string                    Assign a name to the container
        --network string                 Connect a container to a network (default "default")
        --network-alias list             Add network-scoped alias for the container
        --no-healthcheck                 Disable any container-specified HEALTHCHECK
        --oom-kill-disable               Disable OOM Killer
        --oom-score-adj int              Tune host's OOM preferences (-1000 to 1000)
        --pid string                     PID namespace to use
        --pids-limit int                 Tune container pids limit (set -1 for unlimited)
        --privileged                     Give extended privileges to this container
    -p, --publish list                   Publish a container's port(s) to the host
    -P, --publish-all                    Publish all exposed ports to random ports
        --read-only                      Mount the container's root filesystem as read only
        --restart string                 Restart policy to apply when a container exits (default "no")
        --rm                             Automatically remove the container when it exits
        --runtime string                 Runtime to use for this container
        --security-opt list              Security Options
        --shm-size bytes                 Size of /dev/shm
        --sig-proxy                      Proxy received signals to the process (default true)
        --stop-signal string             Signal to stop a container (default "SIGTERM")
        --stop-timeout int               Timeout (in seconds) to stop a container
        --storage-opt list               Storage driver options for the container
        --sysctl map                     Sysctl options (default map[])
        --tmpfs list                     Mount a tmpfs directory
    -t, --tty                            Allocate a pseudo-TTY
        --ulimit ulimit                  Ulimit options (default [])
    -u, --user string                    Username or UID (format: <name|uid>[:<group|gid>])
        --userns string                  User namespace to use
        --uts string                     UTS namespace to use
    -v, --volume list                    Bind mount a volume
        --volume-driver string           Optional volume driver for the container
        --volumes-from list              Mount volumes from the specified container(s)
    -w, --workdir string                 Working directory inside the container








