---
title: Drone各插件的使用
date: 2019-12-13 10:41:17
tags:
- drone
- cicd
categories:
- drone
---

## 概要

前面两篇文章已经介绍了如何部署和如何使用。后面主要是如何写.drone.yml文件了，而.drone.yml文件，是由一个个插件执行一个个的步骤。上一篇也以一个实际的例子简单讲了一些插件的使用与作用，本篇对主要的几个插件进行稍详细的说明。

正常来说，任何一个镜像都可以作为一个插件（如上一篇用到的golang:alpine镜像，就是一个普通的golang镜像）。但在配置文件中使用了settings字段(如使用到了Secrets)或者使用drone自带的环境变量（如DRONE_BUILD_NUMBER），这时就需要对镜像进行一些特殊处理，我们在后续的篇章会专用介绍如何写Drone插件，本篇暂不详述。

## 配置

#### 总框架

实例:
```
kind: pipeline
type: docker
name: <项目名>

steps:
  - name: <step1名>
    image: <镜像名>
    commands:
      - 实际执行的命令1
      - 实际执行的命令2
trigger:
  branch:
    - pvt
```

说明:
```
1. kind: 设定为管道命令(默认值:pipeline，暂没有发现有其他可用值)
2. type: 设定管道类型
    docker: docker管道
    kubernetes: k8s管道，暂不稳定，有泄密风险(基本都可以由docker管道替代)
    exec: Drone Server上执行的命令
    ssh: 可远程登录其他远程机器
    digitalocean: digitalocean云主机专用
3. name: 整个项目的名字
4. step: 执行步骤，此部分是最重要的部分
5. trigger: 触发器
```


#### step详情

实例:
```
- name: 编译
    image: golang:alpine  # 本项目是golang项目, 所以使用go镜像
    environment:
      CGO_ENABLED: "0"    # 指定环境变量
    commands:
      - go build -o test-drone    # 执行编译命令
```


#### 语言插件（以golang为例）

实例:
``` 
  - name: 编译Build
    image: golang:1.13.4
    commands:
      - go test
      - go build
    volumes:
      - name: gopath
        path: /go
    environment:
      GOPROXY: https://goproxy.cn,direct
      GOSUMDB: sum.golang.google.cn
      GOPRIVATE: gitlab.zhaoweiguo.com
      CGO_ENABLED: "0"
```

说明:








