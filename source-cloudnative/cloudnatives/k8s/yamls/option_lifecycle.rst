lifecycle选项
#############

hook都是container级别。

postStart
=========

在container启动时执行，不是container启动前执行，没有先后顺序。

.. literalinclude:: /files/k8s/yamls/option_lifecycle_postStart.yaml
   :language: yaml


preStop
=======

.. literalinclude:: /files/k8s/yamls/option_lifecycle_preStop.yaml
   :language: yaml

Pod停止前相关事件::

    1. Run the pre-stop hook, if one is configured, and wait for it to finish.
    2. Send the SIGTERM signal to the main process of the container.
    3. Wait until the container shuts down cleanly or until the termination grace
    period runs out.
    4. Forcibly kill the process with SIGKILL, if it hasn’t terminated gracefully yet.

优雅停止的时间间隔::

    可通过spec.terminationGracePeriodSeconds指定，单位秒，默认是30

    指定为优雅停止间隔为:5秒
    $ kubectl delete po mypod --grace-period=5

    强制删除, 不优雅停止
    $ kubectl delete po mypod --grace-period=0 --force






