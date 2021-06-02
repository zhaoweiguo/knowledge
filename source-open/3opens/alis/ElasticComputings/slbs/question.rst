.. _ali_slb_question:

常见问题
########

同一台服务器可以重复添加为slb后端服务器的次数超限
=================================================

现象::

    通过k8s的service配置关联slb时,总不成功
    停止在pending状态，各种尝试都不成功，最后连最简单的都不能成功

原因::

    slb_quota_backendserver_attached_num  
    - 同一台服务器可以重复添加为slb后端服务器的次数限制50/50这一项配额满了

解决::

    - 这里可以查配额  https://slb.console.aliyun.com/slb/quota
    - 如果外部流量策略都是cluster  建议改为local  可以省一部分quota   不影响集群外slb的访问  
    - https://help.aliyun.com/document_detail/86531.html

* :ref:`SLB实例限制 <ali_slb_limit>`

disable tls1.0
==============

操作::

    slb -> 指定实例 -> 监听 -> 管理证书 -> 高级 -> TLS安全策略

* 相关: `网站如何禁止tls1.0漏洞 <practice_disable_tls1>`









