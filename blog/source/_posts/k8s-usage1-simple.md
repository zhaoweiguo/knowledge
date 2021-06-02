---
title: kubenates 项目初体验1——最简单项目
date: 2019-07-24 11:46:03
tags:
- k8s
categories:
- k8s
---

### 概要

- 最近因为工作需要, 开始使用k8s
- 我的理念是: 在用中学, 简单学习了基本概念后开始准备实践
- 步骤:
    - 使用gin做一个简单的web项目
    - 编译一个最简单项目
    - 基于alpine打包一个新的docker
    - 运行一个Deployment生成pod
    - 运行一个Service生成服务

### 部署一个最简单项目

- 先确定已经连接上k8s服务:

    ```
    // 如何创建k8s服务后续章节专门写（本章节的k8s服务是直接使用阿里的托管k8s）
    // 基本命令使用也认为各位都已经了解
    $ kubectl get po
    ```

##### 使用go建立一个新项目

- go项目源码

    ```
    $ cat main.go
    func main()  {
      router := gin.Default()
      router.GET("/file", func(c *gin.Context) {
        data := map[string]interface{}{
          "lang": "55555555555",
          "tag":  "9999999",
        }
        c.AsciiJSON(http.StatusOK, data)
      })
      // Listen and serve on 0.0.0.0:8080
      s := &http.Server{
        Addr:           ":8080",
        Handler:        router,
        ReadTimeout:    10 * time.Second,
        WriteTimeout:   10 * time.Second,
        MaxHeaderBytes: 1 << 20,
      }
      s.ListenAndServe()
    }
    ```

- 编译

    ```
    // 生成linux可用的二进制文件
    GOARCH=amd64 GOOS=linux go build -o gordondemo ../main.go
    ```

##### 打包Docker镜像

- Dockerfile文件

    ```
    FROM alpine        # 使用最简单镜像alpine
    ADD gordondemo /   # 把生成的二进制文件放到根目录/中
    ENTRYPOINT ["/gordondemo"]   # 设定入口文件为 /gordondemo (即前面的二进制文件)
    EXPOSE 8080        # 设定开放的http端口8080
    ```

- 打包并推送镜像

    ```
    $ docker build -t registry.cn-beijing.aliyuncs.com/zhaoweiguo/gordondemo:v8 .
    $ docker push registry.cn-beijing.aliyuncs.com/zhaoweiguo/gordondemo:v8
    ```


##### 生成k8s Deployment

- 编辑Deployment的yaml文件

    ```
    $ cat deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: gordondemo
      labels:
        app: gordondemo
    spec:
      replicas: 1    # 指定pod复制数
      template:
        metadata:
          name: gordondemo   
          labels:
            app: gordondemo   # 指定pod名
        spec:
          containers:
            - name: gordondemo
              image: registry.cn-beijing.aliyuncs.com/octopus-test/gordondemo:v8
              imagePullPolicy: IfNotPresent
              # command: ["/app/data-query-service/startdocker.sh", "data-query-service.jar"]
              resources:
                requests:
                  memory: "256Mi"
                limits:
                  memory: "512Mi"
              ports:
                - containerPort: 8080
          restartPolicy: Always
      selector:
        matchLabels:
          app: gordondemo
    ```

- 执行Deployment

    ```
    $ kubectl apply -f deployment.yaml
    ```

##### 生成k8s Service

- 编辑Service的yaml文件

    ```
    // 这儿直接使用阿里云的slb服务
    $ cat service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      annotations:
        service.beta.kubernetes.io/alicloud-loadbalancer-protocol-port: "http:80"
      labels:
        app: gordondemo
      name: gordondemo
      namespace: default
    spec:
      ports:
        - port: 80
          protocol: TCP
          targetPort: 8080
      selector:
        app: gordondemo
      sessionAffinity: None
      type: LoadBalancer

    ```


- 执行Service

    ```
    $ kubectl apply -f service.yaml
    ```


##### 查看、验证

- 查看

    ```
    $ kubectl get deployment
    NAME         DESIRED   CURRENT   UP-TO-DATE   AVAILABLE      AGE
    gordondemo      1         1         1            1           10s
    $ kubectl get svc
    NAME            TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)       AGE
    gordondemo     LoadBalancer   172.21.7.224    xx.xx.xx.xx    80:31807/TCP     10s
    $ kubectl get po
    NAME                             READY      STATUS      RESTARTS     AGE
    gordondemo-65f4dbd959-7ps4v       1/1       Running        0          10s
    ```

- 请求成功

    ```
    // EXTERNAL-IP 对应的就是阿里slb的ip地址(即EXTERNAL-IP对应的字段)
    $ curl xx.xx.xx.xx
    ```











