Topic
---------
::

    Topic:      针对设备的概念，
    Topic类:    针对产品的概念,设定topic规则

    % 系统topic
    a.物模型/sys/
    b.固件升级/ota/
    c.设备影子/shadow/
    d.广播/broadcast

通配符::

    #代表本级及下级所有类目。
    +代表本级所有类目。


高级版::

    设备属性上报(发布)
    /sys/a1v6hhv7xUd/${deviceName}/thing/event/property/post
    设备属性设置(订阅)
    /sys/a1v6hhv7xUd/${deviceName}/thing/service/property/set
    设备事件上报(发布)
    /sys/a1v6hhv7xUd/${deviceName}/thing/event/${tsl.event.identifer}/post
    设备服务调用(订阅)
    /sys/a1v6hhv7xUd/${deviceName}/thing/service/${tsl.event.identifer}
    设备标签上报(发布)
    /sys/a1v6hhv7xUd/${deviceName}/thing/deviceinfo/update

基础版::

    发布
    /uPwUVkJMmrP/${deviceName}/update
    发布
    /uPwUVkJMmrP/${deviceName}/update/error
    订阅
    /uPwUVkJMmrP/${deviceName}/get

RRPC::

    1.系统topic
    RRPC请求消息Topic：
    /sys/${YourProductKey}/${YourDeviceName}/rrpc/request/${messageId}
    RRPC响应消息Topic：
    /sys/${YourProductKey}/${YourDeviceName}/rrpc/response/${messageId}
    RRPC订阅Topic：
    /sys/${YourProductKey}/${YourDeviceName}/rrpc/request/+

    2.自定义topic
    RRPC请求消息Topic：
    /ext/rrpc/${messageId}/${topic}
    如:/ext/rrpc/${messageId}/${YourProductKey}/${YourDeviceName}/request
    RRPC响应消息Topic：
    /ext/rrpc/${messageId}/${topic}
    如:/ext/rrpc/${messageId}/${YourProductKey}/${YourDeviceName}/response
    RRPC订阅Topic：
    /ext/rrpc/+/${topic}

设备影子::

    设备和应用程序发布消息到此Topic。
    物联网平台收到该Topic的消息后，将消息中的状态更新到设备影子中
    /shadow/update/${YourProductKey}/${YourDeviceName}
    设备影子更新状态到该Topic，设备订阅此Topic获取最新消息。
    /shadow/get/${YourProductKey}/${YourDeviceName}

NTP服务::

    请求Topic：
    /ext/ntp/${YourProductKey}/${YourDeviceName}/request
    响应Topic：
    /ext/ntp/${YourProductKey}/${YourDeviceName}/response

固件升级Topic::

    设备端上报固件版本给物联网平台
    /ota/device/inform/${YourProductKey}/${YourDeviceName}
    设备端订阅该topic接收物联网平台的固件升级通知
    /ota/device/upgrade/${YourProductKey}/${YourDeviceName}
    设备端上报固件升级进度
    /ota/device/progress/${YourProductKey}/${YourDeviceName}

Alink-子设备的动态注册::

    % 上行
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/sub/register
    响应Topic： 
    /sys/{productKey}/{deviceName}/thing/sub/register_reply

Alink-拓扑关系::

    % 添加设备拓扑关系, 数据上行
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/topo/add
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/topo/add_reply

    % 删除设备的拓扑关系, 数据上行
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/topo/delete
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/topo/delete_reply

    % 获取设备的拓扑关系, 数据上行
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/topo/get
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/topo/get_reply

    % 发现设备列表上报, 数据上行
    请求Topic：/sys/{productKey}/{deviceName}/thing/list/found
    响应Topic：/sys/{productKey}/{deviceName}/thing/list/found_reply

    % 通知网关添加设备拓扑关系, 数据下行
    请求Topic：/sys/{productKey}/{deviceName}/thing/topo/add/notify
    响应Topic：/sys/{productKey}/{deviceName}/thing/topo/add/notify_reply

Alink-子设备上下线::

    % 数据上行
    请求Topic：
    /ext/session/${productKey}/${deviceName}/combine/login
    响应Topic：
    /ext/session/${productKey}/${deviceName}/combine/login_reply


Alink-物模型(设备属性)::

    % 设备上报属性, 上行（透传）
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/model/up_raw
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/model/up_raw_reply

    % 设备上报属性, 上行（Alink JSON）
    请求Topic： 
    /sys/{productKey}/{deviceName}/thing/event/property/post
    响应Topic： 
    /sys/{productKey}/{deviceName}/thing/event/property/post_reply

    % 设置设备属性, 下行（透传）
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/model/down_raw
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/model/down_raw_reply

    % 设置设备属性, 下行（Alink JSON）
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/service/property/set
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/service/property/set_reply

Alink-物模型(设备事件)::

    % 设备事件上报, 上行（透传）
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/model/up_raw
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/model/up_raw_reply

    % 设备事件上行（Alink JSON）
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/event/{tsl.event.identifier}/post
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/event/{tsl.event.identifier}/post_reply


Alink-物模型(设备服务)::

    % 设备服务调用, 下行（透传）
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/model/down_raw
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/model/down_raw_reply

    % 设备服务调用下行（Alink JSON）
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/service/{tsl.service.identifier}
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/service/{tsl.service.identifier}_reply

Alink-物模型(批量上报)::

    % 网关批量上报数据, 上行（透传）
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/model/up_raw
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/model/up_raw_reply

    % 网关批量上报数据, 上行（Alink JSON）
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/event/property/pack/post
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/event/property/pack/post_reply

Alink-设备期望属性值(desired)::

    % 获取期望属性值, 上行（Alink JSON）
    设备向云端请求获取设备属性的期望值。
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/property/desired/get
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/property/desired/get_reply

    % 清空期望属性值, 上行（Alink JSON）
    设备清除云端设备的期望属性值。
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/property/desired/delete
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/property/desired/delete_reply

Alink-子设备配置下发网关::

    % 云端将网关下所有子设备的连接配置和各子设备所属产品的物模型下发给网关。
    % 配置下发
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/model/config/push

Alink-设备禁用、删除::

    % 禁用设备, 下行
    请求Topic：/sys/{productKey}/{deviceName}/thing/disable
    响应Topic：/sys/{productKey}/{deviceName}/thing/disable_reply

    % 恢复禁用, 下行
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/enable
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/enable_reply

    % 删除设备, 下行
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/delete
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/delete_reply

Alink-设备标签::

    % 标签信息上报, 上行
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/deviceinfo/update
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/deviceinfo/update_reply

    % 删除标签信息, 上行
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/deviceinfo/delete
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/deviceinfo/delete_reply

Alink-TSL模板::

    % 获取设备的TSL模板, 上行请求
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/dsltemplate/get
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/dsltemplate/get_reply

Alink-固件升级::

    % 设备上报固件版本, 数据上行
    Topic：
    /ota/device/inform/${YourProductKey}/${YourDeviceName}

    % 物联网平台推送固件信息, 数据下行
    Topic：
    /ota/device/upgrade/${YourProductKey}/${YourDeviceName}

    % 设备上报升级进度, 数据上行
    Topic:
    /ota/device/progress/${YourProductKey}/${YourDeviceName}

    % 设备请求固件信息, 数据上行
    Topic：
    /ota/device/request/${YourProductKey}/${YourDeviceName}

远程配置::

    % 设备主动请求配置信息, 上行
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/config/get
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/config/get_reply

    % 配置推送, 下行
    请求Topic：
    /sys/{productKey}/{deviceName}/thing/config/push
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/config/push_reply

设备上下线::

    % 不需要专门写?专给服务端用
    /as/mqtt/status/{productKey}/{deviceName}



