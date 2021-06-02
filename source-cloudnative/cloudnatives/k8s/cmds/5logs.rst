kubectl logs
###################

说明::

    打印pod下container日志，如果pod只有唯一container，container值可以省略
    每天or每10MB日志文件被轮替，kubectl logs仅显示最后一次轮替后的日志条目
    

Usage::

    简写: logs, log
    kubectl logs [-f] [-p] (POD | TYPE/NAME) [-c CONTAINER] [options]

实例::

    # 查看指定pod下的日志(pod下只有一个cotainer)
    kubectl logs <podName>

    // -c, --container=''
    # 查看指定pod下指定container的日志
    kubectl logs -c <containerName> <podName>

实例::

    $> kubectl logs mypod --previous   # 获取崩溃容器的应用日志（即前一容器的日志）


example::


    // --all-containers=false
    # Return snapshot logs from pod nginx with multi containers
    kubectl logs nginx --all-containers=true

    // -l, --selector=''
    # Return snapshot logs from all containers in pods defined by label app=nginx
    kubectl logs -lapp=nginx --all-containers=true

    // -p, --previous=false
    # Return snapshot of previous terminated ruby container logs from pod web-1
    kubectl logs -p -c ruby web-1

    // -f, --follow=false
    # Begin streaming the logs of the ruby container in pod web-1
    kubectl logs -f -c ruby web-1

    // --tail=-1
    # Display only the most recent 20 lines of output in pod nginx
    kubectl logs --tail=20 nginx

    // --since-time=''
    # Show all logs from pod nginx written in the last hour
    kubectl logs --since=1h nginx

    # Return snapshot logs from first container of a job named hello
    kubectl logs job/hello

    # Return snapshot logs from container nginx-1 of a deployment named nginx
    kubectl logs deployment/nginx -c nginx-1






