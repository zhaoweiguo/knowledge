API Server
##########

The API server is the central management entity and the only component that talks directly with the distributed storage component etcd.


The API server has the following core responsibilities::

    1. To serve the Kubernetes API. 
        This API is used cluster-internally by the master components, the worker nodes, 
        and your Kubernetes-native apps, as well as externally by clients such as kubectl.
    2. To proxy cluster components
        such as the Kubernetes dashboard, or to stream logs, service ports, or serve kubectl exec sessions.

Serving the API means::

    1. Reading state: 
        getting single objects, listing them, and streaming changes
    2. Manipulating state: 
        creating, updating, and deleting objects

.. figure:: /images/k8s/principle_apiserver1.png

   Kubernetes architecture overview


.. figure:: /images/k8s/principle_version_gvr1.png

   GroupVersionResource (GVR)

COHABITATION::

    Ingress, NetworkPolicy in extensions and networking.k8s.io
    Deployment, DaemonSet, ReplicaSet in extensions and apps 
    Event in the core group and events.k8s.io

REST Mapping::

    GVK <-> GVR


.. figure:: /images/k8s/api_space.png

   An example Kubernetes API space


启动proxy::

    $ kubectl proxy --port=8080

使用::

    curl http://127.0.0.1:8080/apis/batch/v1
    or
    $ kubectl get --raw /apis/batch/v1


.. figure:: /images/k8s/principle_apiserver_request1.png

   Kubernetes API server request processing overview

On a high level, the following interactions take place::

    1. The HTTP request is processed by a chain of filters registered in DefaultBuildHandlerChain(). 
        This chain is defined in k8s.io/apiserver/pkg/server/config.go and discussed in detail shortly.
        It applies a series of filter operations on said request. 
        Either the filter passes and attaches respective information to the context——to be precise, 
          ctx.RequestInfo, with ctx being the context in Go (e.g., the authenticated user)
        ——or, if a request does not pass a filter, 
          it returns an appropriate HTTP response code stating the reason 
          (e.g., a 401 response if the user authentication failed).
    2. Next, depending on the HTTP path, the multiplexer in k8s.io/apiserver/pkg/server/handler.go 
        routes the HTTP request to the respective handler.
    3. A handler is registered for each APIgroup——see k8s.io/apiserver/pkg/endpoints/groupversion.go 
          and k8s.io/apiserver/pkg/endpoints/installer.go for details. 
        It takes the HTTP request as well as the context (for example, user and access rights) 
          and retrieves as well as delivers the requested object from etcd storage.










