kubectl top
###########

Available Commands::

    node        Display Resource (CPU/Memory/Storage) usage of nodes
    pod         Display Resource (CPU/Memory/Storage) usage of pods

Usage::

    kubectl top [flags] [options]


::

    $ kubectl top node

    $ kubectl top pod --all-namespaces
    $ kubectl top pod
