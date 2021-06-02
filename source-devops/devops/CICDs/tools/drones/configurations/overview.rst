综述
========

实例::

    kind: pipeline
    type: docker
    name: default

    steps:
    - name: greeting
      image: golang:1.12
      commands:
      - go build
      - go test

说明::

    pipeline: 在Docker容器中运行shell命令的管道
    Drone会自动下载Docker镜像并运行
    任何commands中的命令得到非0返回值pipeline就会失败并退出


exec::

    kind: pipeline
    type: exec
    name: default

ssh::

    kind: pipeline
    type: ssh
    name: default

    server:
      host: 1.2.3.4
      user: root
      password:
        from_secret: password


digitalocean::

    kind: pipeline
    type: digitalocean
    name: default

    token:
      from_secret: token

    steps:
    - name: greeting
      commands:
      - echo hello world

volumes::

    kind: pipeline
    name: default

    steps:
    - name: test
      image: golang
      volumes:
      - name: deps
        path: /go
      commands:
      - go test

    volumes:
    - name: deps
      temp: {}

环境变量::

    kind: pipeline
    type: docker
    name: default

    steps:
    - name: build
      commands:
      - echo $GOOS          // 
      - echo $${GOARCH}     // 
      - go build
      - go test
      environment:
        GOOS: linux
        GOARCH: amd64












