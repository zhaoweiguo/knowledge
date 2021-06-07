client-go
#########

Kubernetes API Types
====================

The actual Go types are contained in a types.go file (e.g., k8s.io/api/core/v1/types.go).


API Machinery
=============

* http://k8s.io/apimachinery
* It includes all the generic building blocks to implement a Kubernetes-like API.
* API Machinery is not restricted to container management, so, for example, 
* it could be used to build APIs for an online shop or any other business-specific domain.


k8s.io/apimachinery/pkg/apis/meta/v1::

    It contains many of the generic API types such as ObjectMeta, TypeMeta, GetOptions, and ListOptions

client-go
=========

enable protobuf for native Kubernetes resource clients by modifying the REST config::

    cfg, err := clientcmd.BuildConfigFromFlags("", *kubeconfig) 
    cfg.AcceptContentTypes = "application/vnd.kubernetes.protobuf, application/json" 
    cfg.ContentType = "application/vnd.kubernetes.protobuf"
    clientset, err := kubernetes.NewForConfig(cfg)

+-----------+------------+
| client-go | kubernetes |
+===========+============+
| v6.0      | v1.9.0     |
+-----------+------------+
| v7.0      | v1.10.0    |
+-----------+------------+
| v8.0      | v1.11.0    |
+-----------+------------+
| v9.0      | v1.12.0    |
+-----------+------------+
| v10.0     | v1.13.0    |
+-----------+------------+
| v11.0     | v1.14.0    |
+-----------+------------+
| v12.0     | v1.15.0    |
+-----------+------------+
| v0.16.0   | v1.16.0    |
+-----------+------------+
| v0.17.0   | v1.17.0    |
+-----------+------------+


Kubernetes Objects::

    a Go interface called runtime.Object from the package k8s.io/apimachinery/pkg/runtime
    1. Return and set the GroupVersionKind
    2. Be deep-copied







