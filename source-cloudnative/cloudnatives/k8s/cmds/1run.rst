kubect run
#################

说明::

    Create and run a particular image, possibly replicated.
    Creates a deployment or job to manage the created container(s).

Usage::

    kubectl run NAME --image=image [--env="key=value"] [--port=port] [--replicas=replicas] [--dry-run=bool]
      [--overrides=inline-json] [--command] -- [COMMAND] [args...] [options]


实例::

    // 使用临时pod执行命令
    // 运行一个名为srvlookup的一次性pod(--restart=Never),关联控制台(-it),终止后删除(--rm)
    // 查看指定pod的SRV记录
    $> kubectl run -it srvlookup --image=tutum/dnsutils --rm --restart=Never -- \
        dig SRV ruler-eureka-sts-1.ruler-eureka-service.default.svc.cluster.local
    // 查看所有的SRV记录
    $> kubectl run -it srvlookup --image=tutum/dnsutils --rm --restart=Never -- \
        dig SRV ruler-eureka-service.default.svc.cluster.local

Examples::

    # Start a single instance of nginx.
    kubectl run nginx --image=nginx

    # Start a single instance of hazelcast and let the container expose port 5701 .
    kubectl run hazelcast --image=hazelcast --port=5701

    # Start a single instance of hazelcast and set environment variables "DNS_DOMAIN=cluster" and "POD_NAMESPACE=default"
  in the container.
    kubectl run hazelcast --image=hazelcast --env="DNS_DOMAIN=cluster" --env="POD_NAMESPACE=default"

    # Start a single instance of hazelcast and set labels "app=hazelcast" and "env=prod" in the container.
    kubectl run hazelcast --image=nginx --labels="app=hazelcast,env=prod"

    # Start a replicated instance of nginx.
    kubectl run nginx --image=nginx --replicas=5

    # Dry run. Print the corresponding API objects without creating them.
    kubectl run nginx --image=nginx --dry-run

    # Start a single instance of nginx, but overload the spec of the deployment with a partial set of values parsed from
  JSON.
    kubectl run nginx --image=nginx --overrides='{ "apiVersion": "v1", "spec": { ... } }'

    # Start a pod of busybox and keep it in the foreground, don't restart it if it exits.
    kubectl run -i -t busybox --image=busybox --restart=Never

    # Start the nginx container using the default command, but use custom arguments (arg1 .. argN) for that command.
    kubectl run nginx --image=nginx -- <arg1> <arg2> ... <argN>

    # Start the nginx container using a different command and custom arguments.
    kubectl run nginx --image=nginx --command -- <cmd> <arg1> ... <argN>

    # Start the perl container to compute π to 2000 places and print it out.
    kubectl run pi --image=perl --restart=OnFailure -- perl -Mbignum=bpi -wle 'print bpi(2000)'

    # Start the cron job to compute π to 2000 places and print it out every 5 minutes.
    kubectl run pi --schedule="0/5 * * * ?" --image=perl --restart=OnFailure -- perl -Mbignum=bpi -wle 'print bpi(2000)'

说明::

    1.14版:
    kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. 
    Use kubectl run --generator=run-pod/v1 or kubectl create instead.








