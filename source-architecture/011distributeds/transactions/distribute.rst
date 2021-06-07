分布式事务
##########


* 关联: :ref:`CAP <cap>`
* 关联: :ref:`BASE <BASE>`

* 多个服务同时访问多个数据源的事务处理机制，严谨地说，它更应该被称为 “在分布式服务环境下的事务处理机制”。
* BASE 思想的意义在于即使无法做到强一致性，也可以采用合适的方式达到最终一致性，这点在微服务架构中表现得尤为明显
* 实现最终一致性的一些具体方法，包括 ``可靠事件模式`` 、 ``Sagas 长事务模式`` 、 ``补偿模式`` 、 ``TCC 模式`` 、 ``最大努力通知模式`` 和 ``人工干预模式``



.. toctree::
   :maxdepth: 1

   distributes/reliable_event_queue
   distributes/SAGA
   distributes/TCC







