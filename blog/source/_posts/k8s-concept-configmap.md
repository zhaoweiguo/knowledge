---
title: k8s 重要定义——configmap
date: 2019-09-01 12:21:12
tags:
- k8s
- k8s-concept
categories:
- k8s
---

## Configmap


ConfigMap用于保存配置数据的键值对，可以用来保存单个属性，也可以用来保存配置文件

#### 查看命令

查看列表:
```
kubectl get configmap
or
kubectl get cm
```

查看详情:
```
$> kubectl describe cm <configMapName>
```

#### 创建命令

直接创建命令:
```
$> kubectl create configmap <configMapName> 
  --from-literal=nginx_port=80 
  --from-literal=server_name=k8s.zhaoweiguo.com
configmap/<configMapName> created
```

通过文件创建命令:
```
$> cat cm.conf
server {
        server_name k8s.zhaoweiguo.com;
        listen 80;
        root /var/www/;
}
$> kubectl create configmap <configMapName> --from-file=./cm.conf

```

#### 使用ConfigMap-环境变量

配置文件:
```
apiVersion: v1
kind: Pod
metadata:
  name: configmap-pod
  labels:
    app: configmap
spec:
  containers:
  - name: configmap
    image: alpine:v1
    env:
    - name: NGINX_SERVER_PORT
      valueFrom:
        configMapKeyRef:
          name: <configMapName>
          key: nginx_port
    - name: NGINX_SERVER_NAME
      valueFrom:
        configMapKeyRef:
          name: <configMapName>
          key: server_name
```

生成pod并验证configmap的使用:
```
$> kubectl apply -f pod.yaml
pod/configmap-pod created
$> kubectl get pods
NAME                            READY     STATUS    RESTARTS   AGE
configmap-pod                   1/1       Running   0          41s
// 查询内部变量
$> kubectl exec -it pod-cm-1 -- printenv |grep NGINX_SERVER
NGINX_SERVER_PORT=80
NGINX_SERVER_NAME=k8s.zhaoweiguo.com
```

修改configmap的内容看环境变量是否同步生效:
```
$> kubectl edit cm nginx-config
// 把端口号nginx_port改为8888
$>  kubectl describe cm nginx-config
// 查看configmap内容已经修改
$> kubectl exec -it pod-cm-1 -- printenv |grep NGINX_SERVER
NGINX_SERVER_PORT=80
NGINX_SERVER_NAME=k8s.zhaoweiguo.com
// 但环境变量的值并没有被修改
// 环境变量的值要在Pod重启后才会生效
```


#### 使用ConfigMap-存储卷

配置文件:
```
apiVersion: v1
kind: Pod
metadata:
  name: configmap-pod
  labels:
    app: configmap
spec:
  containers:
  - name: myapp
    image: alpine:v1
    volumeMounts:
    - name: nginxconf
      mountPath: /etc/conf.d/
      readOnly: true
  volumes:
  - name: nginxconf
    configMap:
      name: <configMapName>
```

验证configmap的使用:
```
$> kubectl exec -it pod-cm-2 -- /bin/sh
$> ls /etc/conf.d/
nginx_port   server_name
$> cat /etc/conf.d/nginx_port
80
$> cat /etc/conf.d/server_name
k8s.zhaoweiguo.com
```

修改configmap的内容看Volumn是否同步生效:
```
$> kubectl edit cm nginx-config
// 把端口号nginx_port改为8888
$>  kubectl describe cm nginx-config
// 查看configmap内容已经修改
$> cat /etc/conf.d/nginx_port
8888
// Volumn方式文件内容已经自动变化
```






