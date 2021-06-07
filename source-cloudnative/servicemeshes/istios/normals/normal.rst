常用
####

Istio is composed of these components::

    1. Envoy - 
        Sidecar proxies per microservice to handle ingress/egress traffic between services in the cluster 
            and from a service to external services. 
        The proxies form a secure microservice mesh providing a rich set of functions like discovery, 
            rich layer-7 routing, circuit breakers, policy enforcement and telemetry recording/reporting functions.

    2. Mixer - 访问控制、遥测
        Central component that is leveraged by the proxies and microservices 
            to enforce policies such as authorization, rate limits, quotas, 
            authentication, request tracing and telemetry collection.

    3. Pilot - 服务发现、流量管理
        A component responsible for configuring the proxies at runtime.

    4. Citadel - 终端用户认证、流量加密
        A centralized component responsible for certificate issuance and rotation.

    5. Citadel Agent - A per-node component responsible for certificate issuance and rotation.

    6. Galley- Central component for validating, ingesting, aggregating, transforming and distributing config within Istio.

.. note:: Note: The service mesh is not an overlay network. It simplifies and enhances how microservices in an application talk to each other over the network provided by the underlying platform.



.. image:: /images/k8s/istios/architecture.png

Data Plane
==========

The data plane is responsible for translating, forwarding, and monitoring every network packet flowing to and from an instance.

.. image:: /images/k8s/istios/architecture_data.png

Control Plane
=============

Mixer
-----

Adapters::

    Adapters allow Mixer to interact with infrastructure back ends 
      and keep the rest of the Istio abstracted from the provider. 

Attributes::

    Attributes are the smallest data chunk that defines a property of a request.
    Attributes include the request path, IP address to which a request is directed to, 
      response code, response size, request size, and so on. 

Configuration Model::

    1. Handlers: This is responsible for defining the configuration of an adapter.
    2. Instances: This defines how instance attributes should be mapped to adapter inputs. 
    3. Rules: Rules define when to run this flow.

Pilot
-----

* Pilot drives the traffic. 
* It figures out the new path, manages traffic, and handles dead ends.
* In other words, it does the routing, provides service discovery, and facilitates timeouts, retries, circuit breakers, and so on. 


参考
====

* `Stop reinventing the wheel with Istio <https://app.yinxiang.com/fx/e470501b-9796-4167-99b1-8079aa764171>`_

* https://tf.wiki/
* https://www.cnblogs.com/liufei1983/p/10335952.html
* https://blog.csdn.net/zhonglinzhang/article/details/85233390

