常用
####

Docker Compose 是Docker三剑客之一，是 Docker 官方编排（Orchestration）项目之一，负责快速的部署分布式应用。
Compose 定位是 「定义和运行多个 Docker 容器的应用（Defining and running multi-container Docker applications）」，其前身是开源项目 Fig。
docker-compose 是一个用来把 docker 自动化的东西。有了 docker-compose 你可以把所有繁复的 docker 操作全都一条命令，自动化的完成。

Compose 允许用户通过一个单独的 docker-compose.yml 模板文件（YAML 格式）来定义一组相关联的应用容器为一个项目（project）。
Compose 中有两个重要的概念::

    1. 服务 (service): 一个应用的容器，实际上可以包括若干运行相同镜像的容器实例
    2. 项目 (project): 由一组关联的应用容器组成的一个完整业务单元，在 docker-compose.yml 文件中定义

Compose 项目由 Python 编写，实现上调用了 Docker 服务提供的 API 来对容器进行管理。因此，只要所操作的平台支持 Docker API，就可以在其上利用 Compose 来进行编排管理。

实例
====

* 参考自: https://docs.docker.com/compose/gettingstarted/

web 应用::

    from flask import Flask
    from redis import Redis

    app = Flask(__name__)
    redis = Redis(host='redis', port=6379)

    @app.route('/')
    def hello():
        count = redis.incr('hits')
        return 'Hello World! 该页面已被访问 {} 次。\n'.format(count)

    if __name__ == "__main__":
        app.run(host="0.0.0.0", debug=True)

Dockerfile::

    FROM python:3.6-alpine
    ADD . /code
    WORKDIR /code
    RUN pip install redis flask
    CMD ["python", "app.py"]

docker-compose.yml::

    version: '3'
    services:

      web:
        build: .
        ports:
         - "5000:5000"
         
      redis:
        image: "redis:alpine"

运行 compose 项目::

    $ docker-compose -f file.yml up
    or
    $ docker stack deploy -f file.yml <name>












