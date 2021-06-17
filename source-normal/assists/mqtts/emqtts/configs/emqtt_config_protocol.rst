MQTT 协议参数配置
======================

Maximum ClientId Length::

  ## Max ClientId Length Allowed.
  mqtt.max_clientid_len = 1024

Maximum Packet Size::

  ## Max Packet Size Allowed, 64K by default.
  mqtt.max_packet_size = 64KB

MQTT Client Idle Timeout::

  ## Client Idle Timeout (Second)
  mqtt.client.idle_timeout = 30

Enable Per Client Statistics::

  ## Enable client Stats: on | off
  mqtt.client.enable_stats = off

Force GC Count::

  ## Force GC: integer. Value 0 disabled the Force GC.
  mqtt.conn.force_gc_count = 100