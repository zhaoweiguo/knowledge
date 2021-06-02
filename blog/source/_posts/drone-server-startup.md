---
title: 使用Drone搭建CICD服务
date: 2019-11-18 10:11:12
tags:
- drone
- cicd
categories:
- drone
---

## 概要

Drone是Go语言编写的，基于容器技术的CI/CD系统。它具有以下几个关键特性。

Everything is a Docker Container
```
对Docker原生支持使的: drone无需在构建脚本中额外增加 docker 相关的命令就能:
1. 使用Docker化的集成环境方便的实现对多语言编译
2. 利用集成Docker环境的优势: 环境隔离、标准化镜像
利益于: 对原生 Docker 支持
Any Source Code Manager
Any Platform
Any Language
```

<!--more-->
One Server, Multiple Agents
```
Server与git平台交互, 提供web服务
Agents具体负责相关的编译、部署等操作
当使用用户多、load高时可以扩展Agents来实现水平扩容
在 1.0 版本之后，只需要一个 drone 服务
  里面面就内建了 server 及 agent，这很适合用非常小团队快速安装 drone
```

Configuration as a code
```
使用.drone.yml文件来设定测试及部署流程
Pipelines被配置成你提交到git仓库的简单、易读的文件
Pipeline的每一步骤都自动运行在独立的Docker容器中
```

丰富的插件:
```
构建后发送消息: DingTalk, Wechat, Gtalk, Email
构建成功后发布: npm, docker, github release, google container...
构建成功后部署: Kubernetes, rsync, scp, ftp...
```

## 调研其他CI/CD系统

#### 需求

1. 开源软件。可用于商业相关服务的自动化部署
2. 尽量少一些运维部署操作。我们团队都是开发人员，没有专门的运维，开发人员主要工作是编码而不是其它
3. 较好的支持k8s微服务。目前使用了比较多服务使用了k8s
4. 尽量简单，适合小团队使用。服务部署完成后，项目组其他成员可以快速掌握使用
5. 可以与我们搭建的gitlab私有仓库配合使用


#### 常用的CI/CD系统

CI/CD已经形成了一套标准流程，有多个开源不开源的工具可以实现。常用的CI/CD工具有:

CI系统    | 是否开源|授权协议| 开发语言
---------|:------:|------:| -------:
Jenkins  |✅|MIT         | Java
gitlab-ci|✅|MIT         | Golang
prow     |✅|Apache-2.0  | Golang
Strider  |✅|MIT         | JavaScript
Travis   |🚫|商业软件     | Ruby
teamcity |🚫|商业软件      | Java .NET
Codeship |🚫|商业软件      | 未知



这其中:

```
1. Travis、Codeship、teamcity使用商用协议
2. Strider不适用k8s环境的自动化部署
3. prow是专用于k8s项目，是Kubernetes测试框架test-infra的一部分,而且目前好像只适用于github平台

只剩下Jenkins和gitlab-ci适合我们目前开发团队的使用
```

#### Jenkins

优点:
```
  功能完善、插件丰富: 有1000多个插件可供选择
  权限控制粒度高: 可以精确控制每个用户的权限
  稳定性高、文档丰富、使用人数多: 出现问题好解决
```
缺点:
```
  复杂: 1000多个插件, 不下大功夫, 如何知道应该用哪个插件
  权限控制复杂: 精确控制每个用户的权限, 但需要花大量时间配置
  需要对配置文件单独进行版本控制(实现还比较麻烦)
```

#### gitlab-ci
优点:
```
  执行步骤在没有大的中, 自带版本控制
  与gitlab高度整合
```
缺点:
```
  配置复杂
  与gitlab耦合紧密
  开发语言ruby
```


## drone安装

#### 说明

drone支持各git仓库平台, 如github, gitlab, gogs, gitea等。使用不同的仓库平台，安装方式稍有不同。本文以gitlab为例进行说明，其他仓库平台请看[文档](https://docs.drone.io/installation/overview/)

#### 在Gitlab上创建OAuth应用

打开Application页面: 
```
右上角头像 -> 设置(setting) -> 应用(Application)
输入框输入下面2个参数:
  1. Application名: 这个可以随便输入为可识别的名字
  2. Redirect URI: 回调地址, 注意这个地址与后面启动服务的地址+/login
如下图所示:
```

![Application页面](/images/drones/gitlab_token_create.png)

创建成功页面如下图所示:
```
需要记住下面两个值:
Application ID和Secret的值, 后面会用到
```

![Application创建成功页面](/images/drones/gitlab_token_created.png)


#### 创建共享密钥

共享密钥用于在Drone Server与各Drone Runner间通信认证时使用, 本篇使用内建的Server, 此值暂时用处不大, 不明白的可以先记住有这么一个事。
可用如下命令生成:
```
$ openssl rand -hex 16
bea26a2221fd8090ea38720fc445eca6
```

#### 服务启动

服务启动命令如下:
```
docker run \
  --volume=/var/lib/drone:/data \
  --env=DRONE_GIT_ALWAYS_AUTH=false \
  --env=DRONE_GITLAB_SERVER=http://gitlab.com \
  --env=DRONE_GITLAB_CLIENT_ID=${DRONE_GITLAB_CLIENT_ID} \
  --env=DRONE_GITLAB_CLIENT_SECRET=${DRONE_GITLAB_CLIENT_SECRET} \
  --env=DRONE_RPC_SECRET=${DRONE_RPC_SECRET} \
  --env=DRONE_SERVER_HOST=${DRONE_SERVER_HOST} \
  --env=DRONE_SERVER_PROTO=${DRONE_SERVER_PROTO} \
  --env=DRONE_TLS_AUTOCERT=false \
  --env=DRONE_USER_CREATE=username:zhaoweiguo,admin:true \
  --publish=80:80 \
  --publish=443:443 \
  --restart=always \
  --detach=true \
  --name=drone \
  drone/drone:1
```

#### 环境变量参数说明

DRONE_GITLAB_SERVER:
```
gitlab服务地址
```
DRONE_GIT_ALWAYS_AUTH:
```
可选bool型
用于在clone公共项目时认证
此项只有在自托管的Gitlab且启用私有模式时才启用
```
DRONE_GITLAB_CLIENT_ID:
```
前面生成Application时得到的Application ID
```
DRONE_GITLAB_CLIENT_SECRET:
```
前面生成Application时得到的Secret
```
DRONE_RPC_SECRET:
```
Drone Server与各Drone Runner间通信所需要的认证密钥, 即前面使用openssl命令得到的那串32字串
```
DRONE_SERVER_HOST:
```
Drone Server服务的启动地址
```
DRONE_SERVER_PROTO
```
Drone Server服务的协议
```
DRONE_TLS_AUTOCERT:
```
Drone服务默认
```
DRONE_USER_CREATE:
```
设置 Drone 的管理员，格式为:username:<username>,admin:true
本实例中:
  <username> 的值 zhaoweiguo 就是我在gitlab上的用户名
  admin: 指定此用户名的用户为管理员用户
```

#### 说明

docker run启动成功后, 一个单节点的Drone就算是部署完成...
可以通过http://DRONE_SERVER_HOST或https://DRONE_SERVER_HOST访问了


## 参考

[轻量快速的 CI 工具 Drone](https://developer.aliyun.com/article/703141)
[官网](https://docs.drone.io/installation/overview/)

