kubectl describe
######################

Usage::

    kubectl describe (-f FILENAME | TYPE [NAME_PREFIX | -l label] | TYPE/NAME) [options]

    Use "kubectl options" for a list of global command-line options (applies to all commands).


实例::

    $> kubectl describe node    // 查看全部node
    $> kubectl describe node <nodeName>
    $> kubectl describe pod <podName>
    $> kubectl describe svc <svcName>

    # Describe a pod
    kubectl describe pods/nginx

    # Describe a pod identified by type and name in "pod.json"
    kubectl describe -f pod.json

    # Describe all pods
    kubectl describe pods

    # Describe pods by label name=myLabel
    kubectl describe po -l name=myLabel

    # Describe all pods managed by the 'frontend' replication controller (rc-created pods
    # get the name of the rc as a prefix in the pod the name).
    kubectl describe pods frontend











