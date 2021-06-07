kubectl annotate
######################

Usage::

    kubectl annotate [--overwrite] (-f FILENAME | TYPE NAME) KEY_1=VAL_1 ... KEY_N=VAL_N 
        [--resource-version=version]

实例::

    # 将注解zhaoweiguo.com/someannotation添加为值foo bar
    kubectl annotation pod <podName> zhaoweiguo.com/someannotation="foo bar"



Examples::

    # Update pod 'foo' with the annotation 'description' and the value 'my frontend'.
    # If the same annotation is set multiple times, only the last value will be applied
    kubectl annotate pods foo description='my frontend'

    # Update a pod identified by type and name in "pod.json"
    kubectl annotate -f pod.json description='my frontend'

    # Update pod 'foo' with the annotation 'description' and the value 'my frontend running nginx', overwriting any
  existing value.
    kubectl annotate --overwrite pods foo description='my frontend running nginx'

    # Update all pods in the namespace
    kubectl annotate pods --all description='my frontend running nginx'

    # Update pod 'foo' only if the resource is unchanged from version 1.
    kubectl annotate pods foo description='my frontend running nginx' --resource-version=1

    # Update pod 'foo' by removing an annotation named 'description' if it exists.
    # Does not require the --overwrite flag.
    kubectl annotate pods foo description-




