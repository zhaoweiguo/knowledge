Emqtt节点桥接Bridge
===========================

EMQ Node Bridge::

  多个EMQ brokers可以被Bridge在一起。Bridges forward MQTT messages from one broker node to another:

                ---------                     ---------                     ---------
  Publisher --> | Node1 | --Bridge Forward--> | Node2 | --Bridge Forward--> | Node3 | --> Subscriber
                ---------                     ---------                     ---------
  节点间桥接与集群不同，不复制主题树与路由表，只按桥接规则转发 MQTT 消息

Configure Bridge::

  //Create bridge: emqttd1–sensor/#–>emqttd2
  $ cd emqttd1 && ./bin/emqttd_ctl bridges start emqttd2@127.0.0.1 sensor/#

  bridge is started.
  
  $ ./bin/emqttd_ctl bridges list
  bridge: emqttd1@127.0.0.1--sensor/#-->emqttd2@127.0.0.1
  
  //Test the bridge
  #在emqttd2上sub此topic
  mosquitto_sub -t sensor/# -p 2883 -d
  
  #在emqttd1上pub此topic
  mosquitto_pub -t sensor/1/temperature -m "37.5" -d
  
  //Delete the bridge
  ./bin/emqttd_ctl bridges stop emqttd2@127.0.0.1 sensor/#

mosquitto Bridge::

  //Bridge mosquitto to emqttd broker:
               -------------             -----------------
  Sensor ----> | mosquitto | --Bridge--> |               |
               -------------             |      EMQ      |
               -------------             |    Cluster    |
  Sensor ----> | mosquitto | --Bridge--> |               |
               -------------             -----------------
  //mosquitto.conf
  connection emqttd
  address 127.0.0.1:2883
  topic sensor/# out 2
  bridge_protocol_version mqttv311

rsmb Bridge::

  //connection emqttd
  addresses 127.0.0.1:2883
  topic sensor/#broker.cfg:



