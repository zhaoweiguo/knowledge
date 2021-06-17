gitlab实例
##########

创建共享密钥::

    共享密钥用于在Drone Server与各Drone Runner间通信认证时使用
    $ openssl rand -hex 16
    bea26a2221fd8090ea38720fc445eca6

在Gitlab上创建OAuth应用::

    右上角头像 -> 设置(setting) -> 应用(Application)
    输入框输入下面2个参数:
      1. Application名: 这个可以随便输入为可识别的名字
      2. Redirect URI: 回调地址, 注意这个地址与后面启动服务的地址+/login
         
    创建成功需要记住下面两个值:
    Application ID和Secret的值, 后面会用到

说明::

    docker run \
      --volume=/var/run/docker.sock:/var/run/docker.sock \
      --volume=/var/lib/drone:/data \
      --env=DRONE_GIT_ALWAYS_AUTH=false \   # 用于在clone公共项目时认证，只有在自托管的Gitlab且启用私有模式时才启用
      --env=DRONE_GITLAB_SERVER={your-gitlab-url} \  # gitlab 的 URL
      --env=DRONE_GITLAB_CLIENT_ID={your-gitlab-applications-id} \  # GitLab的Application中的id
      --env=DRONE_GITLAB_CLIENT_SECRET={your-gitlab-secret} \       # GitLab的Application中的secret
      --env=DRONE_RPC_SECRET=${DRONE_RPC_SECRET} \        # Server与Runner通信所要密钥,前面用openssl得到的32字串
      --env=DRONE_SERVER_HOST={your-drone-url} \    # drone 的URl
      --env=DRONE_SERVER_PROTO=http \               # Drone Server服务的协议
      --env=DRONE_TLS_AUTOCERT=false \
      --env=DRONE_USER_CREATE=username:{username},admin:true \   # Drone的管理员
      --publish=8000:80 \
      --publish=443:443 \
      --restart=always \
      --detach=true \
      --name=drone \
      drone/drone:1.1


实例::

    docker run \
      --volume=/var/lib/drone:/data \
      --env=DRONE_AGENTS_ENABLED=true \
      --env=DRONE_GITLAB_SERVER=http://gitlab.zhaoweiguo.com \
      --env=DRONE_GITLAB_CLIENT_ID=d6cffd9d9d91a6d2a0ad7xxxxx1b3c12d246ca3c39e1 \
      --env=DRONE_GITLAB_CLIENT_SECRET=94da807ea2eae55599aexxxxx840ba1ddd37314fb611bf \
      --env=DRONE_RPC_SECRET=bea26a2221fxxxxx38720fc445eca6 \
      --env=DRONE_SERVER_HOST=drone.zhaoweiguo.com:7080 \
      --env=DRONE_SERVER_PROTO=http \
      --env=DRONE_USER_CREATE=username:zhaoweiguo,admin:true \
      --publish=7080:80 \
      --publish=7443:443 \
      --restart=always \
      --detach=true \
      --name=drone2 \
      drone/drone:1








