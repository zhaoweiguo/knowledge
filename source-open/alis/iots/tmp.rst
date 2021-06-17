临时
#########


SDK占RAM情况::

    MQTT协议数据传输通过mbedTLS，消耗35K（RAM）= 8K（stack）+27K（heap）。
    CCP协议，消耗45K（RAM） = 32K（stack）+ 13k（heap）

MQTT连接有两种方式，一种是认证再连接，一种是使用域名直连::

    1.认证连接:首先使用HTTPS到iot-auth.cn-shanghai.aliyuncs.com:443获取认证cert后，再使用MQTT连接到/public.iot-as-mqtt.cn-shanghai.aliyuncs.com/1883。 认证连接必须使用TLS加密进行认证
    2.域名直连连接的是：${productKey}.iot-as-mqtt.cn-shanghai.aliyuncs.com:1883。 [productKey是在控制台申请过，具有权限的。]域名直连减少了HTTPS获取证书cert的过程
    3.资源受限设备推荐使用域名直连；一些特殊增值服务，比如设备级别的引流则推荐先HTTPS发送授权后再连接MQTT














