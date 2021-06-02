设备OTA升级
###############

OTA（Over-the-Air Technology）即空中下载技术。物联网平台支持通过OTA方式进行设备固件升级。本文以MQTT协议下的固件升级为例，介绍OTA固件升级流程、数据流转使用的Topic和数据格式。

MQTT协议下固件升级流程如下图所示:

.. figure:: /images/alis/iots/ota1.png
   :width: 80%


1. 设备连接OTA服务，必须上报版本号。设备端通过MQTT协议推送当前设备固件版本号到Topic： /ota/device/inform/${YourProductKey}/${YourDeviceName}::

    {
      "id": 1,
      "params": {
        "version": "xxxxxxxx"
      }
    }

2. 在物联网平台控制台上，逐步添加固件、验证固件和发起批量升级固件。
3. 您在控制台触发升级操作之后，设备会收到物联网平台OTA服务推送的固件的URL地址。设备端订阅Topic： /ota/device/upgrade/${YourProductKey}/${YourDeviceName}。控制台对设备发起固件升级请求后，设备端会通过该Topic收到固件的URL。消息格式如下::

    {
      "code": "1000",
      "data": {
        "size": 432945,
        "version": "2.0.0",
        "url": "https://iotx-ota-pre.oss-cn-shanghai.aliyuncs.com/nopoll_0.4.4.tar.gz?Expires=1502955804&OSSAccessKeyId=XXXXXXXXXXXXXXXXXXXX&Signature=XfgJu7P6DWWejstKJgXJEH0qAKU%3D&security-token=CAISuQJ1q6Ft5B2yfSjIpK6MGsyN1Jx5jo6mVnfBglIPTvlvt5D50Tz2IHtIf3NpAusdsv03nWxT7v4flqFyTINVAEvYZJOPKGrGR0DzDbDasumZsJbo4f%2FMQBqEaXPS2MvVfJ%2BzLrf0ceusbFbpjzJ6xaCAGxypQ12iN%2B%2Fr6%2F5gdc9FcQSkL0B8ZrFsKxBltdUROFbIKP%2BpKWSKuGfLC1dysQcO1wEP4K%2BkkMqH8Uic3h%2Boy%2BgJt8H2PpHhd9NhXuV2WMzn2%2FdtJOiTknxR7ARasaBqhelc4zqA%2FPPlWgAKvkXba7aIoo01fV4jN5JXQfAU8KLO8tRjofHWmojNzBJAAPpYSSy3Rvr7m5efQrrybY1lLO6iZy%2BVio2VSZDxshI5Z3McKARWct06MWV9ABA2TTXXOi40BOxuq%2B3JGoABXC54TOlo7%2F1wTLTsCUqzzeIiXVOK8CfNOkfTucMGHkeYeCdFkm%2FkADhXAnrnGf5a4FbmKMQph2cKsr8y8UfWLC6IzvJsClXTnbJBMeuWIqo5zIynS1pm7gf%2F9N3hVc6%2BEeIk0xfl2tycsUpbL2FoaGk6BAF8hWSWYUXsv59d5Uk%3D",
        "md5": "93230c3bde425a9d7984a594ac55ea1e"
      },
      "id": 1507707025,
      "message": "success"
    }

4. 设备收到URL之后，通过HTTPS协议根据URL下载固件,下载固件过程中，设备端向服务端推送升级进度到Topic： /ota/device/progress/${YourProductKey}/${YourDeviceName}。消息格式如下::

    {
      "id": 1
      "params": {
        "step":"1", 
        "desc":" xxxxxxxx "
      }   
    }

5. 设备端完成固件升级后，推送最新的固件版本到Topic：/ota/device/inform/${YourProductKey}/${YourDeviceName}。如果上报的版本与OTA服务要求的版本一致就认为升级成功，反之失败。













