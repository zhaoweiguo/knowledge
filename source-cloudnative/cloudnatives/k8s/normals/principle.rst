原理
####

kubectl命令创建pod流程:

.. image:: /images/k8s/principle.png

更新原理
===========

Update 机制
-----------

一次完整的 update 操作流程是::

    1. 从 K8s 中拿到一个已经存在的对象（可以选择直接从 K8s 中查询；如果在客户端做了 list watch，推荐从本地 informer 中获取）；
    2. 基于这个取出来的对象做一些修改，比如将 Deployment 中的 replicas 做增减，或是将 image 字段修改为一个新版本的镜像；
    3. 将修改后的对象通过 update 请求提交给 K8s；
    4. kube-apiserver 会校验用户 update 请求提交对象中的 resourceVersion 
        一定要和当前 K8s 中这个对象最新的 resourceVersion 一致，才能接受本次 update。
        否则，K8s 会拒绝请求，并告诉用户发生了版本冲突（Conflict）

kubectl apply 更新版本相关原理图:

.. image:: /images/k8s/principle_version1.png

.. note:: 上图展示了多个用户同时 update 某一个资源对象时会发生的事情。而如果如果发生了 Conflict 冲突，对于 User A 而言应该做的就是做一次重试，再次获取到最新版本的对象，修改后重新提交 update。

结论::

    1. 用户修改 YAML 后提交 update 失败，是因为 YAML 文件中没有包含 resourceVersion 字段。
       对于 update 请求而言，应该取出当前 K8s 中的对象做修改后提交；
    2. 如果两个用户同时对一个资源对象做 update，不管操作的是对象中同一个字段还是不同字段，
       都存在版本控制的机制确保两个用户的 update 请求不会发生覆盖。

Patch 机制
----------

相比于 update 的版本控制，K8s 的 patch 机制则显得更加简单。当用户对某个资源对象提交一个 patch 请求时，kube-apiserver 不会考虑版本问题，而是“无脑”地接受用户的请求（只要请求发送的 patch 内容合法），也就是将 patch 打到对象上、同时更新版本号。

patch 的复杂点在于，目前 K8s 提供了 4 种 patch 策略::

    json patch、
    merge patch、
    strategic merge patch、(默认)
    apply patch（从 K8s 1.14 支持 server-side apply 开始）

通过 kubectl patch -h 命令我们也可以看到这个策略选项::

    $ kubectl patch -h
    # ...
      --type='strategic': The type of patch being provided; one of [json merge strategic]

json patch[RFC 6902]
''''''''''''''''''''''''

实例1-新增容器::

    $ kubectl patch deployment/foo --type='json' -p \
      '[{"op":"add","path":"/spec/template/spec/containers/1","value":{"name":"nginx","image":"nginx:alpine"}}]'

实例2-修改已有容器image::

    $ kubectl patch deployment/foo --type='json' -p \
      '[{"op":"replace","path":"/spec/template/spec/containers/0/image","value":"app-image:v2"}]'

.. warning:: 如果我们 patch 之前这个对象已经被其他人修改了，那么我们的 patch 有可能产生非预期的后果。比如在执行 app 容器镜像更新时，我们指定的序号是 0，但此时 containers 列表中第一个位置被插入了另一个容器，则更新的镜像就被错误地插入到这个非预期的容器中。

merge patch[RFC 7386]
'''''''''''''''''''''

实例1::

    $ kubectl patch deployment/foo --type='merge' -p \
      '{"spec":{"template":{"spec":{"containers":[
          {"name":"app","image":"app-image:v2"},{"name":"nginx","image":"nginx:alpline"}
      ]}}}}'
    说明:
    显然，这个策略并不适合我们对一些列表深层的字段做更新，更适用于大片段的覆盖更新。
    因为:
    merge patch 无法单独更新一个列表中的某个元素，
    因此不管我们是要在 containers 里新增容器、还是修改已有容器的 image、env 等字段，都要用整个 containers 列表来提交 patch



merge适合labels/annotations 这些 map 类型的元素更新::

    $ kubectl patch deployment/foo --type='merge' -p '{"metadata":{"labels":{"test-key":"foo"}}}'

strategic merge patch
'''''''''''''''''''''

.. note:: 这种 patch 策略并没有一个通用的 RFC 标准，而是 K8s 独有的，不过相比前两种而言却更为强大的。

实例1-指定 ``name`` 来修改image(不需要指定序号了)::

    $ kubectl patch deployment/foo -p \
      '{"spec":{"template":{"spec":{"containers":[{"name":"nginx","image":"nginx:mainline"}]}}}}'
    说明:
    如果 K8s 发现当前 containers 中已经有名字为 nginx 的容器，则只会把 image 更新上去
    而如果当前 containers 中没有 nginx 容器，K8s 会把这个容器插入 containers 列表。

.. note:: 目前 strategic 策略只能用于原生 K8s 资源以及 Aggregated API 方式的自定义资源，对于 CRD 定义的资源对象，是无法使用的。这很好理解，因为 kube-apiserver 无法得知 CRD 资源的结构和 merge 策略。如果用 kubectl patch 命令更新一个 CR，则默认会采用 merge patch 的策略来操作





参考
====

* https://mp.weixin.qq.com/s/Vg-x2X86zblIXBoieMi3QA
* https://developer.aliyun.com/article/763325
