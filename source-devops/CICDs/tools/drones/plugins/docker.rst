docker插件
##############

打包镜像::

    docker run --rm \
      -e PLUGIN_TAG=latest \
      -e PLUGIN_REPO=z416177937/z416177937 \
      -e DRONE_COMMIT_SHA=d8dbe4d94f15fe89232e0402c6e8a0ddf21af3ab \
      -v $(pwd):$(pwd) \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -w $(pwd) \
      --privileged \
      plugins/docker --dry-run

打包并推送镜像::

    docker run --rm \
      -e PLUGIN_TAG=latest \
      -e PLUGIN_REPO=xxxxxxs/abc \
      -e DRONE_COMMIT_SHA=d8dbe4d94f15fe89232e0402c6e8a0ddf21af3ab \
      -e DOCKER_USERNAME=z416177937 \
      -e DOCKER_PASSWORD='xxxxxx' \
      -v $(pwd):$(pwd) \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -w $(pwd) \
      --privileged \
      plugins/docker

打包并推送非dockerhub镜像::

    docker run --rm \
      -e PLUGIN_TAG=latest \
      -e PLUGIN_REPO=registry.cn-beijing.aliyuncs.com/zhaoweiguo/test-drone \
      -e DRONE_COMMIT_SHA=d8dbe4d94f15fe89232e0402c6e8a0ddf21af3ab \
      -e DOCKER_USERNAME=zhaoweiguo \
      -e DOCKER_PASSWORD=xxxxxx \
      -e DOCKER_REGISTRY=https://registry.cn-beijing.aliyuncs.com \
      -e PLUGIN_TAGS=v1.0
      -v $(pwd):$(pwd) \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -w $(pwd) \
      --privileged \
      plugins/docker











