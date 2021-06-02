物模型
###########

物模型指将物理空间中的实体数字化，并在云端构建该实体的数据模型。在物联网平台中，定义物模型即定义产品功能。完成功能定义后，系统将自动生成该产品的物模型。物模型描述产品是什么，能做什么，可以对外提供哪些服务。
物模型，简称TSL，即Thing Specification Language。是一个JSON格式的文件。它是物理空间中的实体，如传感器、车载装置、楼宇、工厂等在云端的数字化表示，从属性、服务和事件三个维度，分别描述了该实体是什么，能做什么，可以对外提供哪些信息。定义了这三个维度，即完成了产品功能的定义。

属性（Property）::

    一般用于描述设备运行时的状态，如环境监测设备所读取的当前环境温度等。
    属性支持 GET 和 SET 请求方式。应用系统可发起对属性的读取和设置请求。

服务（Service）::

    设备可被外部调用的能力或方法，可设置输入参数和输出参数。
    相比于属性，服务可通过一条指令实现更复杂的业务逻辑，如执行某项特定的任务。

事件（Event）::

    设备运行时的事件。
    事件一般包含需要被外部感知和处理的通知信息，可包含多个输出参数。如:
      某项任务完成的信息，或者设备发生故障或告警时的温度等，事件可以被订阅和推送。


设备端可以::

    上报属性和事件

云端可以::

    设置设备属性，
    调用设备服务。


物模型格式:

.. literalinclude:: /files/alis/iots/tsl_tpl1.js
   :language: json
   :linenos:



物模型开发
------------

设备属性上报::

    device.postProps({
      CurrentTemperature: 25
    });

    =>
    method: POST_PROPERY: 'thing.event.property.post',
    pubTopic: PROPERTY_POST_TOPIC: '/sys/%s/%s/thing/event/property/post',
    params: props

    =>
    var msg = {
        id: id(),
        version: version,
        params: params,
        method: method
    };
    var payload = JSON.stringify(msg);
    _mqttClient.publish(pubTopic, payload);


事件上报::

    device.postEvent('<eventName>', {
        key1: 'value1'
    });

    => 
    method: POST_EVENT: 'thing.event.<eventName>.post',
    pubTopic: EVENT_POST_TOPIC: '/sys/%s/%s/thing/event/%s/post',

    =>
    var msg = {
        id: id(),
        version: version,
        params: params,
        method: method
    };
    var payload = JSON.stringify(msg);
    _mqttClient.publish(pubTopic, payload);

事件上报回调::

    EVENT_POST_REPLY_TOPIC: '/sys/%s/%s/thing/event/%s/post_reply',









