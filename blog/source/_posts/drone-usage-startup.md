---
title: Drone服务初使用
date: 2019-11-20 18:38:12
tags:
- drone
- cicd
categories:
- drone
---

## 概要

Drone是Go语言编写的，基于容器技术的CI/CD系统。是目前为止个人感觉最轻量级的CI/CD系统，使用本身非常方便容易。目前Drone文档严重缺乏，而且好多文档是之前历史版本的使用文档，所以在安装和使用时会有一些小麻烦，除去这些一切很舒服。前一篇已经写完如何安装Drone，本篇会以一个实例来讲一下，如何用Drone完成一个最简单Golang项目的部署。

<!--more-->

## 激活指定项目

打开部署好的Drone页面:

![首页](/images/drones/drone_page_index1.png)


搜索你要做自动化部署的项目(这儿是test-drone项目):

![搜索页](/images/drones/drone_page_active.png)

点击『ACTIVATE』进入:

![激活前页](/images/drones/drone_page_active2.png)

激活成功进入配置页。注意，Project settings要选择Trusted，因为要挂载宿主机文件系统；其他按需要选择。

![配置页](/images/drones/drone_page_active3.png)

默认配置文件是.drone.yml, 一般也就用这个文件。到此项目激活成功，可以开始下一步行动了。

## 配置私钥

进入配置页面，输入Secret Name和对应的Secret Value后点击「ADD A SECRET」，就成功添加私钥

![配置页](/images/drones/drone_page_secret.png)

#### Docker Hub相关私钥

这儿要配置2个私钥，Docker Hub的用户名和密码，即执行docker login时要输入的用户名和密码
```
docker用户名对应key: docker_user
docker密码对应key:   docker_pass
```

#### DingTalk

本文使用钉钉的小机器人来做通知，这儿需要把钉钉的token也放到私钥中
```
钉钉token对应key:   dingding
```
钉钉token获取方式: 

钉钉组(3人可创建组)  ->  组设置  -> 小组助手  ->  新增

![钉钉助手](/images/drones/drone_dingtalk.png)

选择「自定义」后成功创建助手，查看webhook，如:
https://oapi.dingtalk.com/robot/send?access_token=d4a22b306d1c15a9e80504087cde8e637b8c66fa024554ffef0926a4dea1xxxx

这儿的token=后面的64位字串就是要钉钉的token值

## .drone配置

pipeline主配置

```
kind: pipeline
type: docker
name: demo-go           # 指定项目名称
```
steps配置-编译
``` 
- name: 编译
    image: golang:alpine  # 本项目是golang项目, 所以使用go镜像
    environment:
      CGO_ENABLED: "0"    # 指定环境变量
    commands:
      - go build -o test-drone    # 执行编译命令
```

steps配置-构建镜像
``` 
- name: 构建镜像  
    image: plugins/docker  # 构建docker镜像专用镜像
    volumes:
    - name: docker         # 挂载下面定义的Volumn
      path: /var/run/docker.sock   # 与宿主机用同一docker
    settings:       # plugins/docker用到的相关配置
      username: 
        from_secret: docker_user   # alicloud指定的docker hub的用户名(前面配置)
      password: 
        from_secret: docker_pass   # alicloud指定的docker hub的密码(前面配置)
      repo: registry.cn-beijing.aliyuncs.com/zhaoweiguo/test    # 要推送docker地址
      registry: registry.cn-beijing.aliyuncs.com   # 使用的docker hub地址
      tags: ${DRONE_BUILD_NUMBER}  # docker的tag值, 默认每次加1
```

steps配置-Kubernetes 部署
``` 
  - name: Kubernetes 部署
    image: guoxudongdocker/kubectl:v1.14.1   # 执行kubectl的镜像
    volumes:
      - name: kube            # 挂载下面定义的Volumn
        path: /root/.kube     # 使用宿主机配置的kube配置
    commands:
          # 把deployment.yaml中的#Tag修改为上面打包的docker的tag值
      - sed -i "s/#Tag/${DRONE_BUILD_NUMBER}/g" deployment.yaml 
      - kubectl apply -f deployment.yaml    # 执行kubectl apply
```

steps配置-钉钉通知
``` 
- name: 钉钉通知
    image: guoxudongdocker/drone-dingtalk    # 钉钉通知专用镜像
    settings:
      token:
        from_secret: dingding     # 钉钉的token(前面配置)
      type: markdown
      message_color: true
      message_pic: true
      sha_link: true
    when:
      status: [failure, success]   # 不管成功与否都发通知
 
```
要挂载的volumn:
```
volumes:
- name: kube
  host:
    path: /tmp/cache/.kube    # 注意: 需要提前把kube的配置信息放到指定目录
- name: docker
  host:
    path: /var/run/docker.sock
```

触发条件
```
trigger:
  branch:
    - master   # master分支收到推送就触发
```

## 构建结果

把上面项目提交后，打开构建页面如下:

![构建结果](/images/drones/drone_build1.png)

钉钉也收到通知:

![构建结果](/images/drones/drone_dingtalk2.png)

因为没有输入正确的docker_username，所以这次部署失败了，但不影响大家对整体的了解。

## 说明

本文只是最简单的Go项目编译、构建镜像、部署到k8s以及最后的钉钉通知。只是为了讲解Drone的使用，省略了单元测试、集成测试、可用性测试等。源码参见：
[Drone测试实例源码](https://github.com/zhaoweiguo/test-drone)



