docker tag
###################

Usage::

    为SOURCE_IMAGE创建tag
    docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]

实例::

    $ docker tag friendlyhello gordon/get-started:part2

    // 为已存在的images加tag:
    $ docker tag 5db5f8471261 zhaoweiguo/sinatra:devel

    $ docker tag [ImageId] registry.cn-beijing.aliyuncs.com/gordon-test/gordondemo:v1








