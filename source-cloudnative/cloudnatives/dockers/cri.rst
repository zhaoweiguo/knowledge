容器运行时(Container Runtime)
#############################

* CRI: Kubernetes Container Runtime Interface

* runc: https://github.com/opencontainers/runc
    * the most popular container runtime
    * (runc is written in Go)
    * It’s used by Docker (through containerd), Podman and CRI-O
      * everything expect for LXD (which uses LXC)

* crun: https://github.com/containers/crun
    * runc 的替代品
    * developed by Red Hat and fully written in C 

* containerd: https://github.com/containerd/containerd/
    * CNCF graduating project
* CRI-O: https://github.com/cri-o/cri-o








