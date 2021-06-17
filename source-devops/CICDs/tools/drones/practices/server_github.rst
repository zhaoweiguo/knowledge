github实例
##########

创建共享密钥::

    共享密钥用于在Drone Server与各Drone Runner间通信认证时使用
    $ openssl rand -hex 16
    bea26a2221fd8090ea38720fc445eca6

服务启动命令如下::

    docker run \
      --volume=/var/lib/drone:/data \
      --env=DRONE_AGENTS_ENABLED=true \
      --env=DRONE_GITHUB_SERVER=https://github.com \
      --env=DRONE_GITHUB_CLIENT_ID=${DRONE_GITHUB_CLIENT_ID} \
      --env=DRONE_GITHUB_CLIENT_SECRET=${DRONE_GITHUB_CLIENT_SECRET} \
      --env=DRONE_RPC_SECRET=${DRONE_RPC_SECRET} \
      --env=DRONE_SERVER_HOST=${DRONE_SERVER_HOST} \    # drone 的URl
      --env=DRONE_SERVER_PROTO=${DRONE_SERVER_PROTO} \
      --env=DRONE_TLS_AUTOCERT=false \
      --env=DRONE_USER_CREATE=username:{your-admin-username},admin:true \   # Drone的管理员
      --publish=80:80 \
      --publish=443:443 \
      --restart=always \
      --detach=true \
      --name=drone \
      drone/drone:1

实例::

    docker run \
      --volume=/var/lib/drone:/data \
      --env=DRONE_AGENTS_ENABLED=true \
      --env=DRONE_GITHUB_SERVER=https://github.com \
      --env=DRONE_GITHUB_CLIENT_ID=672a81b131ce0923e440 \
      --env=DRONE_GITHUB_CLIENT_SECRET=75210eebc6eb5b7f6434763507c46d51b600b8a4 \
      --env=DRONE_RPC_SECRET=bea26a2221fd8090ea38720fc445eca6 \
      --env=DRONE_SERVER_HOST=drone.zhaoweiguo.com:7080 \
      --env=DRONE_SERVER_PROTO=http \
      --env=DRONE_TLS_AUTOCERT=false \
      --env=DRONE_USER_CREATE=username:zhaoweiguo,admin:true \
      --publish=7080:80 \
      --publish=7443:443 \
      --restart=always \
      --detach=true \
      --name=drone \
      drone/drone:1




