kubectl exec
###################

Usage::

    kubectl exec (POD | TYPE/NAME) [-c CONTAINER] [flags] -- COMMAND [args...] [options]


实例::

    
    POD_NAMESPACE=ingress-nginx
    POD_NAME=$(kubectl get pods -n $POD_NAMESPACE -l app=ratings -o jsonpath='{.items[0].metadata.name}')
    $> kubectl exec -it $POD_NAME -n $POD_NAMESPACE -- /nginx-ingress-controller --version

    # 注: 双横杠(--)代表kubectl命令项的结束
    #   如需要执行的命令没有以横杠开始的参数，则双横杠也不是必须的
    # 下面情况会导致结果异常和歧义
    $> kubectl exec podName curl -s http://10.10.10.10
    说明:
      在kubectl中-s选项用来告诉kubectl需要连接一个不同的api服务器(不使用默认的)
      上面请求会报不能连接到位于10.10.10.10的服务器

    // 另一个相同的用法:
    $ kubectl exec -it $(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"
    <title>Simple Bookstore App</title>






