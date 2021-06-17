Kubernetes日志采集 [1]_
########################

logtail-ds服务
------------------

要想使用阿里日志，需要启动logtail服务::

    $> kubectl get ds -n kube-system
    NAMESPACE     NAME        DESIRED  CURRENT  READY  AVAILABLE   NODE SELECTOR 
    kube-system   logtail-ds  2        2        2      2           beta.kubernetes.io/os=linux

方法1,新建 Kubernetes 集群::

    勾选了使用日志服务，直接可用

方法2,已创建 Kubernetes 集群，手动安装日志服务组件::

    // 快速判定是否需要进行升级或迁移操作:
    // 如果输出结果为 ALICLOUD_LOG_DOCKER_ENV_CONFIG: true，表示您可正常使用，不需要进行升级或迁移
    $ kubectl describe ds -n kube-system logtail-ds | grep ALICLOUD_LOG_DOCKER_ENV_CONFIG                    

    手动安装(略)


创建应用时配置日志服务
----------------------

方法1,控制台向导创建::

    略

方法2,使用 YAML 模板创建::

    apiVersion: v1
    kind: Pod
    metadata:
      name: my-demo
    spec:
      containers:
      - name: my-demo-app
        image: 'registry.cn-hangzhou.aliyuncs.com/log-service/docker-log-test:latest'
        env:
        - name: aliyun_logs_log-stdout
          value: stdout
        - name: aliyun_logs_log-varlog
          value: /var/log/*.log
        - name: aliyun_logs_mytag1_tags
          value: tag1=v1
        volumeMounts:
        - name: volumn-sls-mydemo
          mountPath: /var/log
      volumes:
      - name: volumn-sls-mydemo
        emptyDir: {}

    // 采集配置的规则
    - name: aliyun_logs_{Logstore 名称}
      value: {日志采集路径}                            

    // 创建自定义 Tag 的规则
    - name: aliyun_logs_{任意不包含'_'的名称}_tags
      value: {Tag 名}={Tag 值}                            

环境变量高级配置::

    aliyun_logs_{key}           // key为logstore名，默认采集方式为极简模式
    aliyun_logs_{key}_tags      // 值为 {tag-key}={tag-value}, 不设置为取全部数据
    aliyun_logs_{key}_project   // 值为指定的日志服务Project, 默认为安装时所选的Project
    aliyun_logs_{key}_logstore  // 值为指定的日志服务Logstore, 默认为{key}
    aliyun_logs_{key}_shard     // 值为创建Logstore时的shard数，有效值为1~10, 默认为2
    aliyun_logs_{key}_ttl       // 值为指定的日志保存时间，有效值为1~3650, 默认90
    aliyun_logs_{key}_machinegroup  // 值为应用的机器组



.. [1] https://help.aliyun.com/document_detail/87540.html