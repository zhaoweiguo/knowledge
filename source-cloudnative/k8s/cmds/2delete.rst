kubectl delete
#######################

Usage::

    kubectl delete ([-f FILENAME] | TYPE [(NAME | -l label | --all)]) [options]


实例::

    // -f, --filename=[]
    $ kubectl delete -f xxx.yml

    // 重启pod(删除pod,deploy监控到,会重新启动一个新的)
    $ kubectl delete po <podName>

    // 使用标签删除
    kubectl delete po -l labelkey1=labelvalue1

    # 删除整个命名空间及下面的pod
    kubectl delete ns <nsName>
    # 删除当前空间的pod但保留命名空间
    kubectl delete po --all
    # 删除当前命令空间中的所有资源(包括RC， Pod及所创建的所有Service)
    kubectl delete all --all   # 第一个all是指定删除所有资源, 第二个--all选项是指定删除下面的所有实例

.. note::

    使用kubectl delete pod无法删除使用kubectl run创建的pod
    原因是: kubectl run命令是创建一个ReplicationController，
    然后再由RC创建Pod, 因此只要删除RC创建的Pod,RC就会重新创建一个，
    因此想删除此Pod,还需要删除这个RC

.. note::

    删除rc并不会影响通过该rc已经创建好的Pod
    可以通过设置replicas的值为0，然后更新此rc

Examples::

    # Delete a pod using the type and name specified in pod.json.
    $ kubectl delete -f ./pod.json
    # Delete a pod based on the type and name in the JSON passed into stdin.
    $ cat pod.json | kubectl delete -f -

    # Delete pods and services with same names "baz" and "foo"
    $ kubectl delete pod,service baz foo

    // -l, --selector=''
    # Delete pods and services with label name=myLabel.
    $ kubectl delete pods,services -l name=myLabel

    // --now=false
    # Delete a pod with minimal delay
    $ kubectl delete pod foo --now

    # Force delete a pod on a dead node
    $ kubectl delete pod foo --grace-period=0 --force

    # Delete all pods
    $ kubectl delete pods --all









