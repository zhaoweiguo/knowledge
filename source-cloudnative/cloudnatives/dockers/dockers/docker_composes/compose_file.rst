Compose 模板文件
################

.. note:: 注意每个服务都必须通过 image 指令指定镜像或 build 指令（需要 Dockerfile）等来自动构建生成镜像。

* 官网: https://docs.docker.com/compose/compose-file/


Compose and Docker compatibility matrix::

    Compose file        format Docker Engine release
    3.8                         19.03.0+
    3.7                         18.06.0+
    3.6                         18.02.0+
    3.5                         17.12.0+
    3.4                         17.09.0+
    3.3                         17.06.0+
    3.2                         17.04.0+
    3.1                         1.13.1+
    3.0                         1.13.0+
    2.4                         17.12.0+
    2.3                         17.06.0+
    2.2                         1.13.0+
    2.1                         1.12.0+
    2.0                         1.10.0+
    1.0                         1.9.1.+





depends_on::

    # 解决容器的依赖、启动先后的问题。以下例子中会先启动 redis db 再启动 web
    version: '3'
    services:
      web:
        build: .
        depends_on:
          - db
          - redis

      redis:
        image: redis

      db:
        image: postgres


environment::

    # 设置环境变量。你可以使用数组或字典两种格式。
    # 只给定名称的变量会自动获取运行 Compose 主机上对应变量的值，可以用来防止泄露不必要的数据。
    environment:
      RACK_ENV: development
      SESSION_SECRET:

    environment:
      - RACK_ENV=development
      - SESSION_SECRET

expose::

    # 暴露端口，但不映射到宿主机，只被连接的服务访问。
    # 仅可以指定内部端口为参数

    expose:
     - "3000"
     - "8000"

logging::

    配置日志选项:
    logging:
      driver: syslog
      options:
        syslog-address: "tcp://192.168.0.42:123"

    目前支持三种日志驱动类型:
    driver: "json-file"
    driver: "syslog"
    driver: "none"

    options 配置日志驱动的相关参数:
    options:
      max-size: "200k"
      max-file: "10"


network_mode::

    设置网络模式。使用和 docker run 的 --network 参数一样的值。

    network_mode: "bridge"
    network_mode: "host"
    network_mode: "none"
    network_mode: "service:[service name]"
    network_mode: "container:[container name/id]"


networks::

    # 配置容器连接的网络

    version: "3"
    services:
      some-service:
        networks:
         - some-network
         - other-network

    networks:
      some-network:
      other-network:

ports::

    暴露端口信息。
    使用宿主端口：容器端口 (HOST:CONTAINER) 格式，或者仅仅指定容器的端口（宿主将会随机选择端口）都可以。

    ports:
     - "3000"
     - "8000:8000"
     - "49100:22"
     - "127.0.0.1:8001:8001"

secrets::

    存储敏感数据，例如 mysql 服务密码。

    version: "3.1"
    services:

    mysql:
      image: mysql
      environment:
        MYSQL_ROOT_PASSWORD_FILE: /run/secrets/db_root_password
      secrets:
        - db_root_password
        - my_other_secret

    secrets:
      my_secret:
        file: ./my_secret.txt
      my_other_secret:
        external: true

volumes::

    数据卷所挂载路径设置。可以设置宿主机路径 （HOST:CONTAINER） 或加上访问模式 (HOST:CONTAINER:ro)
    该指令中路径支持相对路径

    volumes:
     - /var/lib/mysql
     - cache/:/tmp/cache
     - ~/configs:/etc/configs/:ro


* 参考: https://www.jianshu.com/p/2217cfed29d7




