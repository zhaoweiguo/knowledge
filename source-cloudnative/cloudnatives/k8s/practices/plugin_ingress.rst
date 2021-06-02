Ingress(服务暴露) [1]_
##########################

3种服务暴露方式::

    1. NodePort模式
    2. LoadBalance
    3. Ingress资源
    4. ClusterIP // k8s 内部 ip, 仅限内部访问
    5. ExternalName // 会将服务映射到定义的 externName 上

ingress包含两大组件::

    ingress controller和ingress

Ingress Nginx部署
=========================

使用Ingress功能步骤::

    安装部署ingressController Pod
    部署ingress-nginx service
    部署后端服务
    部署ingress

部署ingress controller
----------------------------

下载ingress相关yaml文件 [2]_::
    
    // 不可用(可以去github地址下载)
    $> for filr in namespace.yaml configmap.yaml rbac.yaml tcp-services-configmap.yaml with-rbac.yaml udp-services-configmap.yaml default-backend.yaml;do wget https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/$file;done
    $> ls
    configmap.yaml
    deployment-with-rbac.yaml
    deployment-default-http-backend.yaml
    ingress-default-backend.yaml
    namespace.yaml
    rbac.yaml
    service-nodeport.yaml

创建ingress-nginx名称空间和ingress controller的Pod [3]_::

    $> kubectl apply -f .
    namespace/ingress-nginx created
    configmap/nginx-configuration created
    deployment.extensions/default-http-backend created
    service/default-http-backend created
    serviceaccount/nginx-ingress-serviceaccount created
    clusterrole.rbac.authorization.k8s.io/nginx-ingress-clusterrole configured
    role.rbac.authorization.k8s.io/nginx-ingress-role created
    rolebinding.rbac.authorization.k8s.io/nginx-ingress-role-nisa-binding created
    clusterrolebinding.rbac.authorization.k8s.io/nginx-ingress-clusterrole-nisa-binding created
    configmap/tcp-services created
    configmap/udp-services created
    deployment.extensions/nginx-ingress-controller created


下载defaultbackend镜像::

    defaultbackend镜像:
    // 方法1:
    [root@node01 ~]# docker pull mirrorgooglecontainers/defaultbackend-amd64:1.5
    1.5: Pulling from mirrorgooglecontainers/defaultbackend-amd64
    9ecb1e82bb4a: Pull complete 
    Digest: sha256:d08e129315e2dd093abfc16283cee19eabc18ae6b7cb8c2e26cc26888c6fc56a
    Status: Downloaded newer image for mirrorgooglecontainers/defaultbackend-amd64:1.5

    [root@node01 ~]# docker tag mirrorgooglecontainers/defaultbackend-amd64:1.5 k8s.gcr.io/defaultbackend-amd64:1.5
    [root@node01 ~]# docker image ls
    REPOSITORY                                    TAG                 IMAGE ID            CREATED             SIZE
    mirrorgooglecontainers/defaultbackend-amd64   1.5                 b5af743e5984        34 hours ago        5.13MB
    k8s.gcr.io/defaultbackend-amd64               1.5                 b5af743e5984        34 hours ago        5.13MB   

    // 方法2:
    // 我个人建立的ali镜像
    $> docker pull registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/defaultbackend-amd64:1.5
    $> docker tag registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/defaultbackend-amd64:1.5 k8s.gcr.io/defaultbackend-amd64:1.5

nginx-ingress-controller镜像::

    $> docker pull registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/nginx-ingress-controller:0.25.0
    $> docker tag registry.cn-hangzhou.aliyuncs.com/xxxxxxxx/nginx-ingress-controller:0.25.0 quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.25.0


部署ingress-nginx service
-----------------------------

下载ingress-controller service的yaml文件::

    $> wget https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/baremetal/service-nodeport.yaml

创建ingress-controller的service::

    $> kubectl apply -f service-nodeport.yaml 
    service/ingress-nginx created
    $> kubectl get svc -n ingress-nginx
    NAME                   TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
    default-http-backend   ClusterIP   10.107.114.219   <none>        80/TCP                       27m
    ingress-nginx          NodePort    10.108.12.235    <none>        80:31875/TCP,443:32020/TCP   38s

部署ingress
----------------

查看ingress的配置清单选项::

    $> kubectl explain ingress.spec

编写ingress的配置清单并创建ingress::

    $> kubectl apply -f ingress-default-backend.yaml 
    ingress.extensions/ingress-default-backend created

查看ingress-default-backend的详细信息::

    $> kubectl describe ingress -n ingress-nginx ingress-default-backend
    Name:             ingress-default-backend
    Namespace:        ingress-nginx
    Address:          
    Default backend:  default-http-backend:80 (<none>)
    Rules:
      Host                 Path  Backends
      ----                 ----  --------
      default.backend.com  
                              default-http-backend:80 (<none>)
    Annotations:
      kubernetes.io/ingress.class:                       nginx
      kubectl.kubernetes.io/last-applied-configuration:  {"apiVersion":"extensions/v1beta1","kind":"Ingress","metadata":{"annotations":{"kubernetes.io/ingress.class":"nginx"},"name":"ingress-default-backend","namespace":"ingress-nginx"},"spec":{"rules":[{"host":"default.backend.com","http":{"paths":[{"backend":{"serviceName":"default-http-backend","servicePort":80},"path":null}]}}]}}

    Events:
      Type    Reason  Age   From                      Message
      ----    ------  ----  ----                      -------
      Normal  CREATE  9m    nginx-ingress-controller  Ingress ingress-nginx/ingress-default-backend

进入nginx-ingress-controller进行查看是否注入了nginx配置::

    $> kubectl get pods -n ingress-nginx
    NAME                                        READY     STATUS    RESTARTS   AGE
    default-http-backend-7db7c45b69-znpxp       1/1       Running   0          1h
    nginx-ingress-controller-6bd7c597cb-fgdz8   1/1       Running   0          1h
    
    $> kubectl exec -n ingress-nginx -ti nginx-ingress-controller-6bd7c597cb-fgdz8 -- /bin/sh
    $ cat nginx.conf
    ....
    ....

Detect installed version::

    $> POD_NAMESPACE=ingress-nginx
    $> POD_NAME=$(kubectl get pods -n $POD_NAMESPACE -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].metadata.name}')

    $> kubectl exec -it $POD_NAME -n $POD_NAMESPACE -- /nginx-ingress-controller --version

通过ingress访问服务::

    // 修改本地host文件(/etc/hosts)
    192.168.116.128 default.backend.com
    192.168.116.129 default.backend.com

    $> curl default.backend.com:30124

察看相关
-----------
::

    $> kubectl get pods --all-namespaces
    NAMESPACE       NAME                                        READY   STATUS    RESTARTS   AGE
    ingress-nginx   default-http-backend-58d599d98b-h2nkh       1/1     Running   0          166m
    ingress-nginx   nginx-ingress-controller-7995bd9c47-q66z8   1/1     Running   0          170m
    kube-system     coredns-5c98db65d4-glnwm                    1/1     Running   4          5h16m
    ... ...

    $> kubectl get svc --all-namespaces
    NAMESPACE     NAME                 TYPE      CLUSTER-IP     EXTERNAL-IP PORT(S)                    AGE
    default       kubernetes           ClusterIP 10.96.0.1      <none>      443/TCP                    5h17m
    ingress-nginx default-http-backend ClusterIP 10.108.134.159 <none>      80/TCP                     167m
    ingress-nginx ingress-nginx        NodePort  10.107.171.237 <none>      80:30124/TCP,443:32111/TCP 4m8s
    kube-system   kube-dns             ClusterIP 10.96.0.10     <none>      53/UDP,53/TCP,9153/TCP     5h17m
    kube-system   kubernetes-dashboard NodePort  10.98.19.210   <none>      443:30000/TCP              4h37m

    $> kubectl get ingresses --all-namespaces
    NAMESPACE       NAME                      HOSTS                 ADDRESS   PORTS   AGE
    ingress-nginx   ingress-default-backend   default.backend.com             80      9m11s

    $> kubectl get deployments --all-namespaces
    NAMESPACE       NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
    ingress-nginx   default-http-backend       1/1     1            1           174m
    ingress-nginx   nginx-ingress-controller   1/1     1            1           177m
    kube-system     coredns                    2/2     2            2           5h23m
    kube-system     kubernetes-dashboard       1/1     1            1           4h44m

    $> kubectl get secret --all-namespaces
    NAMESPACE     NAME                                     TYPE                                DATA AGE
    default       default-token-stzz6                      kubernetes.io/service-account-token 3    5h24m
    ingress-nginx default-token-5kj8n                      kubernetes.io/service-account-token 3    178m
    ingress-nginx nginx-ingress-serviceaccount-token-flk6t kubernetes.io/service-account-token 3    178m


构建TLS站点
---------------

准备证书并生成secret::

    $> openssl genrsa -out tls.key 2048
    Generating RSA private key, 2048 bit long modulus
    ............................+++
    ..................+++
    e is 65537 (0x10001)

    $> openssl req -new -x509 -key tls.key -out tls.crt -subj /C=CN/ST=Beijing/L=Beijing/O=DevOps/CN=tomcat.zwx.com

生成secret::

    $> kubectl create secret tls tomcat-ingress-secret --cert=tls.crt --key=tls.key
    secret/tomcat-ingress-secret created

    $> kubectl get secret
    NAME                    TYPE                                  DATA      AGE
    default-token-l9jws     kubernetes.io/service-account-token   3         12d
    tomcat-ingress-secret   kubernetes.io/tls                     2         33s

    $> kubectl describe secret tomcat-ingress-secret
    Name:         tomcat-ingress-secret
    Namespace:    default
    Labels:       <none>
    Annotations:  <none>

    Type:  kubernetes.io/tls

    Data
    ====
    tls.crt:  1285 bytes
    tls.key:  1679 bytes

创建ingress::

    $> vim ingress-tomcat-tls.yaml
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: ingress-tomcat-tls
      namespace: default
      annotations:
        kubernetes.io/ingress.class: "nginx"
    spec:
      tls:
      - hosts:
        - tomcat.zwx.com
        secretName: tomcat-ingress-secret
      rules:
      - host: tomcat.zwx.com
        http:
          paths:
          - backend:
              serviceName: tomcat
              servicePort: 8080
    
    $> kubectl apply -f ingress-tomcat-tls.yaml 
    ingress.extensions/ingress-tomcat-tls created

使用::

    $> curl https://tomcat.zwx.com:32020


.. [1] https://blog.csdn.net/cloudUncle/article/details/82940598
.. [2] https://github.com/kubernetes/ingress-nginx
.. [3] 附录1

.. literalinclude:: files/ingress_namespace.yml

.. literalinclude:: files/ingress_configmap.yml

.. literalinclude:: files/ingress_rbac.yml

.. literalinclude:: files/ingress_default-backend.yml

.. literalinclude:: files/ingress_deployment-with-rbac.yml

.. literalinclude:: files/ingress_deployment-default-http-backend.yml

.. literalinclude:: files/ingress_service-nodeport.yml









