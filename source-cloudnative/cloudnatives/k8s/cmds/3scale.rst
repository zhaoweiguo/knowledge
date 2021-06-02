kubectl scale
####################

Usage::

    kubectl scale [--resource-version=version] [--current-replicas=count] 
      --replicas=COUNT (-f FILENAME | TYPE NAME) [options]

实例-rc(replication controllers)::

    # 增加rc格式pod副本数
    kubectl scale rc kubia --replicas=3

    # Scale multiple replication controllers.
    kubectl scale --replicas=5 rc/foo rc/bar rc/baz

实例-rs(replicas sets)::

    # 增加rs格式pod副本数
    kubectl scale --replicas=3 rs/foo

    # Scale a resource identified by type and name specified in "foo.yaml" to 3.
    kubectl scale --replicas=3 -f foo.yaml

实例-deployment::

    # If the deployment named mysql's current size is 2, scale mysql to 3.
    $ kubectl scale --current-replicas=2 --replicas=3 deployment/mysql
    # 直接scale到2
    $ kubectl scale --replicas=2 deployment webapp-deployment

实例-sts(statefulset)::

    # Scale statefulset named 'web' to 3.
    $ kubectl scale --replicas=3 statefulset/web
    or
    $ kubectl scale sts web --replicas=3






