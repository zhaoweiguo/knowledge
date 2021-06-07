kubectl get
####################

用法::

    kubectl get 
      [(-o|--output=)json|yaml|wide|custom-columns=...|custom-columns-file=...
          |go-template=...|go-template-file=...|jsonpath=...|jsonpath-file=...]
      (TYPE[.VERSION][.GROUP] [NAME | -l label] | TYPE[.VERSION][.GROUP]/NAME ...) [flags] [options]



实例::

    $> kubectl get pods                   # 可简写为 kubectl get po
    $> kubectl get replicationcontroller  # 可简写为 kubectl get rc
    $> kubectl get services               # 可简写为 kubectl get svc
    $> kubectl get nodes
    $> kubectl get cronjob 
    $> kubectl get jobs
    $> kubectl get event --watch

    // 获取全部类型的资源
    $> kubectl get all



定时相关::

    // 查看crontab情况
    $ kubectl get cronjob 
    $ kubectl get cronjob <cronName>

    // 查看 Job 的执行情况
    $> kubectl get jobs
    $> kubectl get jobs <jobName>

    // cron第一次执行job
    $ kubectl get cronjob 
    NAME         SCHEDULE     SUSPEND   ACTIVE    LAST SCHEDULE   AGE
    goanalysis   35 6 * * *   False     0         <none>          2m29s
    // cron在3分钟多前执行过一次
    $ kubectl get cronjob 
    NAME         SCHEDULE     SUSPEND   ACTIVE    LAST SCHEDULE   AGE
    goanalysis   35 6 * * *   False     0         3m5s            6m57s


pod::

    # 列出pods时显示更多信息（如node名,ip等）
    $> kubectl get pods -o wide

    # 展示出停止状态的信息
    $> kubectl get jobs --show-all -o wide
    
    // --show-labels
    # 显示label
    $> kubectl get pods --show-labels

    // -L, --label-columns=[] 
    # 显示指定label
    $> kubectl get pods -L labelkey1,labelkey2

    // -l, --selector=''
    # 过滤指定k/v
    $> kubectl get po -l labelkey1=labelvalue1
    $> kubectl get po -l labelkey1!=labelvalue1
    $> kubectl get po -l labelkey1 in (value1, value2)
    $> kubectl get po -l labelkey1 notin (value1, value2)
    # 有key1标签的
    $> kubectl get po -l key1
    # 没有key1标签的
    $> kubectl get po -l '!key1'

    // -o, --output=''
    # 查看指定pod详情
    $> kubectl get pods <podName> -o yaml

services::

    # 查看指定services
    $> kubectl get svc <serviceName> -o yaml

    # 查询入口网关服务的 IP 地址
    kubectl get service serviceName -n default -o jsonpath="{.status.loadBalancer.ingress[*].ip}"


node::

    kubectl get nodes -l labelkey1=labelvalue1

    # 查看node详情
    $> kubectl get node <nodeName> -o yaml

replicationcontroller::

    # 列出单个rc
    $ kubectl get replicationcontroller web

namespace::

    # 列出所有ns
    kubectl get ns
    # 列出指定ns的pods列表
    kubectl get po --namespace <nsName>
    or
    kubectl get po -n <nsName>

查看configmap::

    $> kubectl get configmap --all-namespaces
    $> kubectl get configmap <configName>  -o yaml

监听::

    -w, --watch=false
    # 查看Pod删除和重新创建的过程
    $ kubectl get pod -w -l app=nginx

    # 查看事件(详见下表)
    $> kubectl get event --watch

表:创建pod过程

 +--------------------------+------+-----------------------------+-----------+-------------------+----------------------------------+------------------------------------------------------------------+
 | NAME                     | KIND | SUBOBJECT                   | TYPE      | REASON            | SOURCE                           | MESSAGE                                                          |
 +==========================+======+=============================+===========+===================+==================================+==================================================================+
 | podname.15f33648d8e97c9e | Pod  | Normal                      | Scheduled | default-scheduler | empty                            | Successfully assigned default/podname to cn-beijing.172.17.5.201 |
 +--------------------------+------+-----------------------------+-----------+-------------------+----------------------------------+------------------------------------------------------------------+
 | podname.15f336490a33b960 | Pod  | spec.containers{main}       | Normal    | Pulling           | kubelet, cn-beijing.172.17.5.201 | pulling image "tutum/curl"                                       |
 +--------------------------+------+-----------------------------+-----------+-------------------+----------------------------------+------------------------------------------------------------------+
 | podname.15f3365333f4c0ac | Pod  | spec.containers{main}       | Normal    | Pulled            | kubelet, cn-beijing.172.17.5.201 | Successfully pulled image "tutum/curl"                           |
 +--------------------------+------+-----------------------------+-----------+-------------------+----------------------------------+------------------------------------------------------------------+
 | podname.15f33653360a1912 | Pod  | spec.containers{main}       | Normal    | Created           | kubelet, cn-beijing.172.17.5.201 | Created container                                                |
 +--------------------------+------+-----------------------------+-----------+-------------------+----------------------------------+------------------------------------------------------------------+
 | podname.15f336534846ab6a | Pod  | spec.containers{main}       | Normal    | Started           | kubelet, cn-beijing.172.17.5.201 | Started container                                                |
 +--------------------------+------+-----------------------------+-----------+-------------------+----------------------------------+------------------------------------------------------------------+
 | podname.15f336534853dc05 | Pod  | spec.containers{ambassador} | Normal    | Pulling           | kubelet, cn-beijing.172.17.5.201 | pulling image "luksa/kubectl-proxy:1.6.2"                        |
 +--------------------------+------+-----------------------------+-----------+-------------------+----------------------------------+------------------------------------------------------------------+
 | podname.15f33655386fb6bc | Pod  | spec.containers{ambassador} | Normal    | Pulled            | kubelet, cn-beijing.172.17.5.201 | Successfully pulled image "luksa/kubectl-proxy:1.6.2"            |
 +--------------------------+------+-----------------------------+-----------+-------------------+----------------------------------+------------------------------------------------------------------+
 | podname.15f336553a336296 | Pod  | spec.containers{ambassador} | Normal    | Created           | kubelet, cn-beijing.172.17.5.201 | Created container                                                |
 +--------------------------+------+-----------------------------+-----------+-------------------+----------------------------------+------------------------------------------------------------------+
 | podname.15f336554fa3b009 | Pod  | spec.containers{ambassador} | Normal    | Started           | kubelet, cn-beijing.172.17.5.201 | Started container                                                |
 +--------------------------+------+-----------------------------+-----------+-------------------+----------------------------------+------------------------------------------------------------------+
 | podname.15f33668368bddae | Pod  | spec.containers{ambassador} | Normal    | Killing           | kubelet, cn-beijing.172.17.5.201 | Killing container with id docker://ambassador:Need to kill Pod   |
 +--------------------------+------+-----------------------------+-----------+-------------------+----------------------------------+------------------------------------------------------------------+
 | podname.15f336683a3b25f0 | Pod  | spec.containers{main}       | Normal    | Killing           | kubelet, cn-beijing.172.17.5.201 | Killing container with id docker://main:Need to kill Pod         |
 +--------------------------+------+-----------------------------+-----------+-------------------+----------------------------------+------------------------------------------------------------------+

其他::

    # List deployments in JSON output format, in the "v1" version of the "apps" API group:
    $ kubectl get deployments.v1.apps -o json

    # List a single pod in JSON output format.
    $ kubectl get -o json pod web-pod-13je7

    # List a pod identified by type and name specified in "pod.yaml" in JSON output format.
    $ kubectl get -f pod.yaml -o json

    # Return only the phase value of the specified pod.
    $ kubectl get -o template pod/web-pod-13je7 --template={{.status.phase}}

    # List all replication controllers and services together in ps output format.
    $ kubectl get rc,services

    # List one or more resources by their type and names.
    $ kubectl get rc/web service/frontend pods/web-pod-13je7

    // 查看各组件信息
    $ kubectl get componentstatuses
    NAME                 STATUS    MESSAGE             ERROR
    controller-manager   Healthy   ok
    scheduler            Healthy   ok
    etcd-0               Healthy   {"health":"true"}

    以其他格式打印
    $ k get po -o yaml
    $ k get po -o json
    $ k get po <POD> -o jsonpath="Name: {.metadata.name} Status: {.status.phase}"
    
    允许的格式有:
    custom-columns,custom-columns-file,go-template,go-template-file,
    json,jsonpath,jsonpath-file,name,template,templatefile,wide,yaml


JSONPath Support [1]_
=====================

实例1
-----

json格式(如: k get po -o json)::

    {
      "kind": "List",
      "items":[
        {
          "kind":"None",
          "metadata":{"name":"127.0.0.1"},
          "status":{
            "capacity":{"cpu":"4"},
            "addresses":[{"type": "LegacyHostIP", "address":"127.0.0.1"}]
          }
        },
        {
          "kind":"None",
          "metadata":{"name":"127.0.0.2"},
          "status":{
            "capacity":{"cpu":"8"},
            "addresses":[
              {"type": "LegacyHostIP", "address":"127.0.0.2"},
              {"type": "another", "address":"127.0.0.3"}
            ]
          }
        }
      ],
      "users":[
        {
          "name": "myself",
          "user": {}
        },
        {
          "name": "e2e",
          "user": {"username": "admin", "password": "secret"}
        }
      ]
    }

函数说明::

    text:     kind is {.kind} 
    @:        {@} (the current object )
    . or []:  {.kind} or {[‘kind’]}
    ..:       {..name}
    *:        {.items[*].metadata.name} 
    [start:end :step]:    {.users[0].name}
    [,]:      {.items[*][‘metadata.name’, ‘status.capacity’]} 
    ?():      {.users[?(@.name==“e2e”)].user.password}  
    range, end:   {range .items[*]}[{.metadata.name}, {.status.capacity}] {end} 
    “:            {range .items[*]}{.metadata.name}{’\t’}{end}

实例::

    kubectl get pods -o json
    kubectl get pods -o=jsonpath='{@}'
    kubectl get pods -o=jsonpath='{.items[0]}'
    kubectl get pods -o=jsonpath='{.items[0].metadata.name}'
    kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.startTime}{"\n"}{end}'

On Windows::

    C:\> kubectl get pods -o=jsonpath="{range .items[*]}{.metadata.name}{'\t'}{.status.startTime}{'\n'}{end}"
    C:\> kubectl get pods -o=jsonpath="{range .items[*]}{.metadata.name}{\"\t\"}{.status.startTime}{\"\n\"}{end}"

实例2
-----

input::

    $ kubectl  get svc first-deployment -o yaml
    apiVersion: v1
    kind: Service
    metadata:
      creationTimestamp: "2020-04-22T06:44:41Z"
      labels:
        app: first-deployment
      name: first-deployment
      namespace: default
      resourceVersion: "529"
      selfLink: /api/v1/namespaces/default/services/first-deployment
      uid: a25ff4b7-0ee9-4fdc-b134-6c66f9431bc1
    spec:
      clusterIP: 10.110.122.106
      externalTrafficPolicy: Cluster
      ports:
      - nodePort: 31012
        port: 80
        protocol: TCP
        targetPort: 80
      selector:
        app: first-deployment
      sessionAffinity: None
      type: NodePort
    status:
      loadBalancer: {}

使用::

    $ export PORT=$(kubectl get svc first-deployment \
      -o go-template='{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}')

实例3
-----


Get ExternalIPs of all nodes::

    kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="ExternalIP")].address}'

List Names of Pods that belong to Particular RC::

    sel=${$(kubectl get rc my-rc --output=json | jq -j '.spec.selector | to_entries | .[] | "\(.key)=\(.value),"')%?}
    echo $(kubectl get pods --selector=$sel --output=jsonpath={.items..metadata.name})

Check which nodes are ready::

    JSONPATH='{range .items[*]}{@.metadata.name}:{range @.status.conditions[*]}{@.type}={@.status};{end}{end}' \
     && kubectl get nodes -o jsonpath="$JSONPATH" | grep "Ready=True"

List all Secrets currently in use by a pod::

    kubectl get pods -o json | jq '.items[].spec.containers[].env[]?.valueFrom.secretKeyRef.name' | grep -v null | sort | uniq

List all containerIDs of initContainer of all pods::

    # Helpful when cleaning up stopped containers, while avoiding removal of initContainers.
    kubectl get pods --all-namespaces -o jsonpath='{range .items[*].status.initContainerStatuses[*]}{.containerID}{"\n"}{end}' | cut -d/ -f3






.. [1] https://kubernetes.io/docs/reference/kubectl/jsonpath/










