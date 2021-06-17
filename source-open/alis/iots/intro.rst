简介
###########

阿里云物联网平台为设备提供安全可靠的连接通信能力，向下连接海量设备，支撑设备数据采集上云；向上提供云端API，指令数据通过API调用下发至设备端，实现远程控制。

物联网平台的主要能力
---------------------

1.设备接入
2.设备管理
3.安全能力
4.规则引擎
5.数据分析
6.边缘计算

架构
------
设备连接物联网平台，与物联网平台进行数据通信。物联网平台可将设备数据流转到其他阿里云产品中进行存储和处理。这是构建物联网应用的基础

.. figure:: /images/alis/iots/architecture_design1.png
   :width: 100%



标签::

    产品标签、
    设备标签
    分组标签


服务端订阅
--------------
::

    % 设备上报消息
    /${YourProductKey}/${YourDeviceName}/user/get ，具有订阅权限
    /${YourProductKey}/${YourDeviceName}/user/update，具有发布权限。
    /sys/${YourProductKey}/${YourDeviceName}/thing/event/property/post，具有发布权限。

    % 设备状态变化通知
    /as/mqtt/status/${YourProductKey}/${YourDeviceName}

    % 网关发现子设备上报
    % 设备拓扑关系变更
    % 设备生命周期变更

消息体包含的内容::

    public class Message {
        // 消息体
        private byte[] payload;
        // Topic 
        private String topic;
        // 消息ID
        private String messageId;
        // QoS
        private int qos;
    }

其他
-------

泛化协议::

    阿里云物联网平台已经支持基于MQTT、CoAP和HTTP等一些协议的通信，
    其他类型协议，如消防协议GB/T 26875.3-2011、Modbus、JT808等暂未接入，
    此时，您需要使用泛化协议SDK，快速构建桥接服务，搭建设备或平台与阿里云物联网平台的双向数据通道。

RRPC::

    RRPC：Revert-RPC。RPC（Remote Procedure Call）采用客户机/服务器模式


.. figure:: /images/alis/iots/rrpc.png
   :width: 80%


NTP服务::

    物联网平台提供NTP服务，解决嵌入式设备资源受限，系统不包含NTP服务，端上没有精确时间戳的问题。








