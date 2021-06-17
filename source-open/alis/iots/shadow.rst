设备影子
###########

物联网平台提供设备影子功能，用于缓存设备状态。设备在线时，可以直接获取云端指令；设备离线时，上线后可以主动拉取云端指令。

设备影子是一个 JSON 文档，用于存储设备上报状态、应用程序期望状态信息。

每个设备有且只有一个设备影子，设备可以通过MQTT获取和设置设备影子来同步状态，该同步可以是影子同步给设备，也可以是设备同步给影子。

应用场景::

    场景1：网络不稳定，设备频繁上下线
    场景2：多程序同时请求获取设备状态
    场景3：设备掉线

设备影子JSON文档示例::

    {
        "state": {
            "desired": {    % 设备的预期状态,一般是app写
                "color": "RED", 
                "sequence": [
                    "RED", 
                    "GREEN", 
                    "BLUE"
                ]
            }, 
            "reported": {   % 设备的报告状态,设备写
                "color": "GREEN"
            }
        }, 
        "metadata": {
            "desired": {
                "color": {
                    "timestamp": 1469564492
                }, 
                "sequence": {
                    "timestamp": 1469564492
                }
            }, 
            "reported": {
                "color": {
                    "timestamp": 1469564492
                }
            }
        }, 
        "timestamp": 1469564492, 
        "version": 1
    }

实例
-------

设备主动上报状态
''''''''''''''''''

设备在线时，主动上报设备状态到影子，应用程序主动获取设备影子状态。

1.当灯泡lightbulb联网时，使用Topic /shadow/update/a1PbRCFQWfX/lightbulb上报最新状态到影子::

    {
      "method": "update", 
      "state": {
        "reported": {
          "color": "red"
        }
      }, 
      "version": 1
    }

2.当设备影子接收到灯泡上报状态时，成功更新影子文档::

    {
      "state": {
        "reported": {
          "color": "red"
        }
      }, 
      "metadata": {
        "reported": {
          "color": {
            "timestamp": 1469564492
          }
        }
      }, 
      "timestamp": 1469564492, 
      "version": 1
    }

3.影子文件更新后，设备影子会返回结果给设备::

    % 成功
    {
      "method": "reply", 
      "payload": {
        "status": "success", 
        "version": 1
      }, 
      "timestamp": 1469564576
    }

    % 失败
    {
      "method": "reply", 
      "payload": {
        "status": "error", 
        "content": {
          "errorcode": "${errorcode}", 
          "errormessage": "${errormessage}"
        }
      }, 
      "timestamp": 1469564576
    }

应用程序改变设备状态
''''''''''''''''''''''''
应用程序下发期望状态给设备影子，设备影子将文件下发给设备端。设备根据影子更新状态，并上报最新状态至影子

1.应用程序发消息到Topic /shadow/update/a1PbRCFQWfX/lightbulb/中，要求更改灯泡状态::

    {
      "method": "update", 
      "state": {
        "desired": {
          "color": "green"
        }
      }, 
      "version": 2
    }

2.设备影子接收到更新请求，更新其影子文档为::

    {
      "state": {
        "reported": {
          "color": "red"
        }, 
        "desired": {
          "color": "green"
        }
      }, 
      "metadata": {
        "reported": {
          "color": {
            "timestamp": 1469564492
          }
        }, 
        "desired": {
          "color": {
            "timestamp": 1469564576
          }
        }
      }, 
      "timestamp": 1469564576, 
      "version": 2
    }

3.设备影子更新完成后，发送返回结果到Topic/shadow/get/a1PbRCFQWfX/lightbulb中。返回结果信息构成由设备影子决定::

    {
      "method": "control", 
      "payload": {
        "status": "success", 
        "state": {
          "reported": {
            "color": "red"
          }, 
          "desired": {
            "color": "green"
          }
        }, 
        "metadata": {
          "reported": {
            "color": {
              "timestamp": 1469564492
            }
          }, 
          "desired": {
            "color": {
              "timestamp": 1469564576
            }
          }
        }
      }, 
      "version": 2, 
      "timestamp": 1469564576
    }

4.因为设备灯泡在线，并且订阅了Topic/shadow/get/a1PbRCFQWfX/lightbulb，所以会收到消息。
收到消息后，根据请求文档中desired的值，将灯泡颜色变成绿色。
灯泡更新完状态后，上报最新状态到物联网平台::

    {
      "method": "update", 
      "state": {
        "reported": {
          "color": "green"
        }
      }, 
      "version": 3
    }

5.最新状态上报成功后

5.1设备端发消息到Topic/shadow/update/a1PbRCFQWfX/lightbulb中清空desired属性。消息如下::

    {
      "method": "update", 
      "state": {
        "desired": "null"
      }, 
      "version": 4
    }

5.2设备影子会同步更新，此时的影子文档如下::

    {
      "state": {
        "reported": {
          "color": "green"
        }
      }, 
      "metadata": {
        "reported": {
          "color": {
            "timestamp": 1469564577
          }
        }, 
        "desired": {
          "timestamp": 1469564576
        }
      }, 
      "version": 4
    }

设备主动获取影子内容
''''''''''''''''''''''

若应用程序发送指令时，设备离线。设备再次上线后，将主动获取设备影子内容

1.灯泡主动发送以下消息到Topic/shadow/update/a1PbRCFQWfX/lightbulb中，获取设备影子中保存的最新状态::

    {
        "method": "get"
    }

2.当设备影子收到这条消息时，发送最新状态到Topic/shadow/get/a1PbRCFQWfX/lightbulb。灯泡通过订阅该Topic获取最新状态。消息内容如下::

    {
      "method": "reply", 
      "payload": {
        "status": "success", 
        "state": {
          "reported": {
            "color": "red"
          }, 
          "desired": {
            "color": "green"
          }
        }, 
        "metadata": {
          "reported": {
            "color": {
              "timestamp": 1469564492
            }
          }, 
          "desired": {
            "color": {
              "timestamp": 1469564492
            }
          }
        }
      }, 
      "version": 2, 
      "timestamp": 1469564576
    }

设备主动删除影子属性
''''''''''''''''''''''''
若设备端已经是最新状态，设备端可以主动发送指令，删除设备影子中保存的某条属性状态。

发送以下内容到Topic/shadow/update/a1PbRCFQWfX/lightbulb中

1.删除影子中某一属性::

    {
      "method": "delete", 
      "state": {
        "reported": {
          "color": "null", 
          "temperature": "null"
        }
      }, 
      "version": 1
    }

2.删除影子全部属性::

    {
      "method": "delete", 
      "state": {
        "reported": "null"
      }, 
      "version": 1
    }








