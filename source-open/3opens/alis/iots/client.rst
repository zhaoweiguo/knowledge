设备client开发指南
#####################


MQTT保活::

    设备端在保活时间间隔内，至少需要发送一次报文，包括ping请求。
    如果物联网平台在保活时间内无法收到任何报文，物联网平台会断开连接，设备端需要进行重连。
    连接保活时间的取值范围为30至1200秒。建议取值300秒以上。




MQTT-TCP客户端直连
--------------------

1. 推荐使用TLS加密
2. 使用MQTT客户端连接服务器。连接方法

3.1. 连接域名::

    ${YourProductKey}.iot-as-mqtt.${YourRegionId}.aliyuncs.com:1883

3.2. 可变报头（variable header）::

    Connect指令中需包含Keep Alive（保活时间）。
    保活心跳时间取值范围为30至1200秒。
    如果心跳时间不在此区间内，物联网平台会拒绝连接。
    建议取值300秒以上。如果网络不稳定，将心跳时间设置高一些。

3.3. MQTT的Connect报文参数::

    mqttClientId: clientId+"|securemode=3,signmethod=hmacsha1,timestamp=132323232|"
    mqttUsername: deviceName+"&"+productKey
    mqttPassword: sign_hmac(deviceSecret,content)

    注:
    clientId：表示客户端ID，建议使用设备的MAC地址或SN码，64字符内
        格式中|securemode=3,signmethod=hmacsha1,timestamp=132323232|为扩展参数
        signmethod:表示签名算法类型。支持hmacmd5，hmacsha1和hmacsha256，默认为hmacmd5
        securemode：表示目前安全模式，可选值有2 （TLS直连模式）和3（TCP直连模式）
    mqttPassword:sign签名需把提交给服务器的参数按字典排序后，根据signmethod加签名
    实例:
      假设:
        clientId = 12345，deviceName = device， 
        productKey = pk， timestamp = 789，
        signmethod=hmacsha1，deviceSecret=secret，
        那么使用TCP方式提交给MQTT的参数如下:
           mqttclientId=12345|securemode=3,signmethod=hmacsha1,timestamp=789|
           mqttUsername=device&pk
           mqttPassword=hmacsha1("secret","clientId12345deviceNamedeviceproducypktimestamp789").toHexString(); 
        加密后的Password为二进制转16制字符串，示例结果为:
          FAFD82A3D602B37FB0FA8B7892F24A477F851A14

MQTT-TCP使用HTTPS认证再连接
-----------------------------

1. 认证设备::

    使用HTTPS进行设备认证，认证域名为:
    https://iot-auth.${YourRegionId}.aliyuncs.com/auth/devicename
    其中，${YourRegionId}请参考地域和可用区替换为您的Region ID。

    请求参数:
      productKey  必选  ProductKey，从物联网平台的控制台获取。
      deviceName  必选  DeviceName，从物联网平台的控制台获取。
      sign        必选  签名，格式为hmacmd5(deviceSecret,content)
      signmethod  可选  算法类型。支持hmacmd5，hmacsha1和hmacsha256，默认为hmacmd5。
      clientId    必选  表示客户端ID，64字符内。
      timestamp   可选  时间戳。时间戳不做时间窗口校验。
      resources   可选  希望获取的资源描述，如MQTT。 多个资源名称用逗号隔开
    返回参数:
      iotId     必选  服务器颁发的一个连接标记，用于赋值给MQTT connect报文中的username。
      iotToken  必选  token有效期为7天，赋值给MQTT connect报文中的password。
      resources 可选  资源信息，扩展信息比如MQTT服务器地址和CA证书信息等

    x-www-form-urlencoded请求示例:
      POST /auth/devicename HTTP/1.1
      Host: iot-auth.cn-shanghai.aliyuncs.com
      Content-Type: application/x-www-form-urlencoded
      Content-Length: 123
      productKey=123&sign=123&timestamp=123&version=default&clientId=123&resouces=mqtt&deviceName=test
      sign = hmac_md5(deviceSecret, clientId123deviceNametestproductKey123timestamp123)

    请求响应:
      HTTP/1.1 200 OK
      Server: Tengine
      Date: Wed, 29 Mar 2017 13:08:36 GMT
      Content-Type: application/json;charset=utf-8
      Connection: close
      {
           "code" : 200,
           "data" : {
              "iotId" : "42Ze0mk3556498a1AlTP",
              "iotToken" : "0d7fdeb9dc1f4344a2cc0d45edcb0bcb",
              "resources" : {
                  "mqtt" : {
                     "host" : "xxx.iot-as-mqtt.cn-shanghai.aliyuncs.com",
                     "port" : 1883
              }
            }
            },
            "message" : "success"
      }

2. 连接MQTT::

    采用TLS建立连接。
    客户端通过CA证书验证物联网平台服务器；
    物联网平台服务器通过MQTT协议体内connect报文信息验证客户端


MQTT-WebSocket连接通信
----------------------------

使用WebSocket方式主要有以下优势::

    使基于浏览器的应用程序可以像普通设备一样，具备与服务端建立MQTT长连接的能力。
    WebSocket方式使用443端口，消息可以顺利穿过大多数防火墙。

MQTT连接参数和TCP直接连接方式完全相同，其中要注意::

    securemode参数，使用wss方式连接时securemode=2，使用ws方式连接时securemode=3


