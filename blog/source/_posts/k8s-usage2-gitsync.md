---
title: kubenates 项目初体验2——git同步项目
date: 2019-07-28 10:36:13
tags:
- k8s
- gitsync
categories:
- k8s
---

## 概要


- 本项目主要实现了基于git的项目同步, 技术为nginx+html

    - git公有项目同步
    - git私有项目同步
    - 部署一个简单的nginx反向代理html

## git公有项目同步

- 基于开源项目: git-sync[^1]
- 最简单的https公有项目同步[^2]

    - 使用git-sync做项目同步
    - 使用nginx做反向代理
    - 两个容器在同一个Pod内，挂载同一个磁盘完成项目同步

- 配置实例:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: blog
spec:
  replicas: 1
  selector:
    matchLabels:
      name: blog
  template:
    metadata:
      labels:
        name: blog
    spec:
      containers:
      - name: git-sync
        image: k8s.gcr.io/git-sync:v3.0.1
        volumeMounts:
        - name: markdown
          mountPath: /tmp/git
        env:
        - name: GIT_SYNC_REPO
          value: https://github.com/kubernetes/git-sync.git
        - name: GIT_SYNC_DEST
          value: git-sync
      - name: hugo
        image: k8s.gcr.io/hugo
        volumeMounts:
        - name: markdown
          mountPath: /src
        - name: html
          mountPath: /dest
        env:
        - name: HUGO_SRC
          value: /src/git-sync/demo/blog
        - name: HUGO_BUILD_DRAFT
          value: "true"
        - name: HUGO_BASE_URL
          value: example.com
      - name: nginx
        image: nginx
        volumeMounts:
        - name: html
          mountPath: /usr/share/nginx/html
      volumes:
      - name: markdown
        emptyDir: {}
      - name: html
        emptyDir: {}
```


## git私有项目同步

- 简单说明:

    - https协议的地址克隆需要输入密码(输入密码方案暂没找到合适的方法)
    - ssh协议的地址克隆需要私钥(此方案要把私钥存放到指定目录才可用)
    - k8s中的Secret类型专门用于存储私私钥

#### 创建私钥

- 方法一:

```
$> ssh-keyscan $YOUR_GIT_HOST > /tmp/known_hosts
// 指定git的密钥和known_hosts
$> kubectl create secret generic git-creds \
      --from-file=ssh=/Users/zhaoweiguo/.ssh/gordon.git \
      --from-file=known_hosts=/tmp/known_hosts
```

- 方法二:

```
$> ssh-keyscan $YOUR_GIT_HOST > /tmp/known_hosts
$> cat /path/to/secret-config.json
{
  "kind": "Secret",
  "apiVersion": "v1",
  "metadata": {
    "name": "git-creds"
  },
  "data": {
    "ssh": <base64 encoded private-key>           # 这儿是密钥的base64
    "known_hosts": <base64 encoded known_hosts>   # 这儿是known_hosts的base64
  }
}

// 执行
$> kubectl create -f /path/to/secret-config.json
```

#### 配置私钥Pod Volume

- 查看确定私钥已经创建成功:
```
zhaowgMac:k8s zhaoweiguo$ kubectl get secret
NAME                  TYPE                                  DATA      AGE
git-creds             Opaque                                2         22d
```

- git私钥volumes配置
```
# ...
volumes:
- name: git-secret
  secret:
    secretName: git-creds      # 这儿就是前面指定Secret的名
    defaultMode: 288 # 0440
# ...
```

#### 配置git-sync容器

- 参数说明
```
-ssh: 指定使用ssh协议
-repo: 指定git地址
-dest: 指定clone后的文件夹名
-branch: 指定git分支名
```

- git-sync容器配置
```
# ...
containers:
- name: git-sync
  image: k8s.gcr.io/git-sync:v9.3.76
  args:
   - "-ssh"
   - "-repo=git@github.com:foo/bar"
   - "-dest=bar"
   - "-branch=master"
  volumeMounts:
  - name: git-secret
    mountPath: /etc/git-secret
  securityContext:
    runAsUser: 65533 # git-sync user
# ...
```



## 完整实例

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
    name: php-deployment
spec:
    replicas: 1
    selector:
        matchLabels:
            app: php
    template:
        metadata:
            labels:
                app: php
        spec:
            containers:
              - name: git-sync # 启动 git-sync 容器
                image: registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/git-sync:v3.1.1
                args:
                  - "-ssh"
                  - "-repo=git@gitee.com:agents/private.git"
                  - "-dest=private"   # git克隆后文件夹名
                  - "-branch=master"  # git分支名
                  - "-depth=1"        # 没有sub
                  - "-root=/git"      # 克隆到指定目录
                securityContext:
                  runAsUser: 65533 # git-sync user(指定用户)
                volumeMounts: # 挂载数据卷
                  - mountPath: /git    # git项目在git-sync容器存储地址
                    name: web-root
                  - name: git-secret
                    mountPath: /etc/git-secret   # 私有git地址需要用到的私钥目录
              - name: nginx
                image: registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/nginx:alpine-v1
                volumeMounts:
                  - name: web-root
                    mountPath: /usr/share/nginx/html  # git项目在nginx容器存储地址
            volumes:
              - name: web-root
                emptyDir: {}
              - name: git-secret
                secret:
                  secretName: git-creds
                  defaultMode: 288 # = mode 0440

```


[^1]: https://github.com/kubernetes/git-sync
[^2]: https://medium.com/@thanhtungvo/build-git-sync-for-side-car-container-in-kubernetes-4ee51bda84f0




