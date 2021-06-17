Topic+通信数据
#####################

设备上报属性:上行（Alink JSON）::

    请求Topic： 
    /sys/{productKey}/{deviceName}/thing/event/property/post
    {
      "id": "123",
      "version": "1.0",
      "params": {
        "Power": {
          "value": "on",
          "time": 1524448722000
        },
        "WF": {
          "value": 23.6,
          "time": 1524448722000
        }
      },
      "method": "thing.event.property.post"
    }

    响应Topic： 
    /sys/{productKey}/{deviceName}/thing/event/property/post_reply
    {
      "id": "123",
      "code": 200,
      "data": {}
    }

设置设备属性:下行（Alink JSON）::

    请求Topic：
    /sys/{productKey}/{deviceName}/thing/service/property/set
    {
      "id": "123",
      "version": "1.0",
      "params": {
        "temperature": "30.5"
      },
      "method": "thing.service.property.set"
    }

    响应Topic：
    /sys/{productKey}/{deviceName}/thing/service/property/set_reply
    {
      "id": "123",
      "code": 200,
      "data": {}
    }

设备事件上报:上行（Alink JSON）::

    请求Topic：
    /sys/{productKey}/{deviceName}/thing/event/{tsl.event.identifier}/post
    {
      "id": "123",
      "version": "1.0",
      "params": {
        "value": {
          "Power": "on",
          "WF": "2"
        },
        "time": 1524448722000
      },
      "method": "thing.event.{tsl.event.identifier}.post"
    }
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/event/{tsl.event.identifier}/post_reply
    {
        "id":"123",
        "code":200,
        "method":"thing.event.{tsl.event.identifier}.post"
        "data":{}
    }

设备服务调用:下行（Alink JSON）::

    请求Topic：
    /sys/{productKey}/{deviceName}/thing/service/{tsl.service.identifier}
    {
      "id": "123",
      "version": "1.0",
      "params": {
        "Power": "on",
        "WF": "2"
      },
      "method": "thing.service.{tsl.service.identifier}"
    }

    响应Topic：
    /sys/{productKey}/{deviceName}/thing/service/{tsl.service.identifier}_reply
    {
      "id": "123",
      "code": 200,
      "data": {}
    }

网关批量上报数据:上行（Alink JSON）::

    请求Topic：
    /sys/{productKey}/{deviceName}/thing/event/property/pack/post
    {
      "id": "123", 
      "version": "1.0", 
      "params": {
        "properties": {
          "Power": {
            "value": "on", 
            "time": 1524448722000
          }, 
          "WF": {
            "value": { }, 
            "time": 1524448722000
          }
        }, 
        "events": {
          "alarmEvent1": {
            "value": {
              "param1": "on", 
              "param2": "2"
            }, 
            "time": 1524448722000
          }, 
          "alertEvent2": {
            "value": {
              "param1": "on", 
              "param2": "2"
            }, 
            "time": 1524448722000
          }
        }, 
        "subDevices": [
          {
            "identity": {
              "productKey": "", 
              "deviceName": ""
            }, 
            "properties": {
              "Power": {
                "value": "on", 
                "time": 1524448722000
              }, 
              "WF": {
                "value": { }, 
                "time": 1524448722000
              }
            }, 
            "events": {
              "alarmEvent1": {
                "value": {
                  "param1": "on", 
                  "param2": "2"
                }, 
                "time": 1524448722000
              }, 
              "alertEvent2": {
                "value": {
                  "param1": "on", 
                  "param2": "2"
                }, 
                "time": 1524448722000
              }
            }
          }
        ]
      }, 
      "method": "thing.event.property.pack.post"
    }
    
    响应Topic：
    /sys/{productKey}/{deviceName}/thing/event/property/pack/post_reply
    {
      "id": "123",
      "code": 200,
      "data": {}
    }










