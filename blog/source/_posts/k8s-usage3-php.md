---
title: kubenates 项目初体验3——nginx+php+memcached项目
date: 2019-08-16 14:31:23
tags:
- k8s
- php
categories:
- k8s
---

## 概要

前一篇文章完成了git同步相关工作，使用nginx做反向代理，本篇完成PHP项目的部署，主要包括以下内容:

  - 使用ConfigMap完成Nginx的配置
  - 基于官方php-fpm镜像安装所需要的PHP插件并生成新的镜像备用
  - 使用阿里LoadBalance完成服务部署

## 使用ConfigMap完成Nginx的配置

配置内容:
```
    apiVersion: v1
    kind: ConfigMap
    metadata:
        name: nginx-config
        namespace: nginx
    data:
        chnupdate.conf: |
            server {
                listen       80;
                server_name  web.zhaoweiguo.com;
                root   /opt/service-new/webroot;
                access_log  /var/log/nginx/access.log;
                error_log  /var/log/nginx/error.log debug;
                add_header Access-Control-Allow-Origin  *;
                client_max_body_size  128M;
                location / {
                     try_files $uri /index.php$is_args$args;
                }
                location ~ \.php$ {
                    root   /opt/service-new/webroot;
                    fastcgi_pass   127.0.0.1:9000;
                    fastcgi_index  index.php;
                    fastcgi_param  SCRIPT_FILENAME  $document_root/$fastcgi_script_name;
                    include        fastcgi_params;
                }
            }
```

注意:
```
1. 这儿设定好的目录是/opt/service-new/webroot
2. php服务是127.0.0.1的9000端口
```

## 使用Secret设置git密钥

获取git服务的known_hosts内容:
```
$> ssh-keyscan $YOUR_GIT_HOST > /tmp/known_hosts
例:
$> ssh-keyscan gitee.com > /tmp/known_hosts
```


获取known_hosts和密钥的base64:
```
$> cat /tmp/known_hosts | base64
$> cat /Users/zhaoweiguo/.ssh/gordon.git | base64
```

新建名为zwgSecret的Secret:

```
apiVersion: v1
kind: Secret
metadata:
    name: zwgSecret
    namespace: nginx
data:
    ssh: LS0tLS1CRUdJTiB......tCg==
    known_hosts: Z2l0Y29......EQnZ1BMFNrMzN
```
or

```
$> kubectl create secret generic zwgSecret \
      --from-file=ssh=/Users/zhaoweiguo/.ssh/gordon.git \
      --from-file=known_hosts=/tmp/known_hosts
```


## 使用Deployment设置php,nginx服务

说明:

```
    1. 一个pod下面有3个容器git-sync, php, nginx
    2. git-sync容器只负责把代码clone到指定位置,并保证代码是最新的
    3. php容器
```

配置文件:

```
apiVersion: apps/v1
kind: Deployment
metadata:
    name: php-appupdate-deployment
spec:
    replicas: 1
    selector:
        matchLabels:
            app: php-appupdate
    template:
        metadata:
            labels:
                app: php-appupdate
        spec:
            containers:
              - name: git-sync # 启动 git-sync 容器
                image: registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/git-sync:v3.1.1
                args:
                  - "-ssh"
                  - "-repo=git@git.zhaoweiguo.com:gordon/smart_upload.git"
                  - "-dest=service-new"
                  - "-branch=master"
                  - "-depth=1"
                  - "-root=/gitpath"
                securityContext:
                  runAsUser: 65533 # git-sync user(指定用户)
                volumeMounts: # 挂载数据卷
                  - mountPath: /gitpath
                    name: web-root
                  - name: git-secret
                    mountPath: /etc/git-secret
              - name: nginx
                image: registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/nginx:alpine
                volumeMounts:
                  - name: nginx-config
                    mountPath: /etc/nginx/conf.d
                  - name: web-root
                    mountPath: /opt
              - name: php
                image: registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/php:5.5-fpm-v4
                imagePullPolicy: IfNotPresent
                volumeMounts:
                  - name: web-root
                    mountPath: /opt
            volumes:
              - name: nginx-config
                configMap:
                  name: nginx-config
              - name: web-root
                emptyDir: {}
              - name: git-secret
                secret:
                  secretName: zwgSecret
                  defaultMode: 288 # = mode 0440
            securityContext:
              fsGroup: 65533 # to make SSH key readable(指定用户组)
```













