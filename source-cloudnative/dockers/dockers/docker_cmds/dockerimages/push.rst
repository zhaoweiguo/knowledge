docker push
#####################

Usage::

    # Push an image or a repository to a registry
    docker push [OPTIONS] NAME[:TAG]


Options::

      --disable-content-trust   Skip image signing (default true)

实例::

    $ docker push zhaoweiguo/demo  // 推送前需要先login

    $ docker push registry.cn-beijing.aliyuncs.com/gordon-test/gordondemo:v1


