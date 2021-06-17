Emqtt版本
=============



Version 1.0 (The Seven Mile Journey)::

  1.Full MQTT V3.1/3.1.1 Protocol Specifications Support
  2.Massively scalable - Scaling to 1 million connections on a single server
  3.Distributed - Route MQTT Messages among clustered or bridged broker nodes
  4.Extensible - LDAP, MySQL, PostgreSQL, Redis Authentication/ACL Plugins

Version 2.0 “West of West Lake”::

  1.First of all, the EMQ broker now supports Shared Subscription and Local Subscription.
  2.Supports CoAP(RFC 7252) and MQTT-SN protocol/gateway.
  3.Adopt a more user-friendly k = v syntax for the new configuration file.
  4.Add more hooks and new plugins, integrate with HTTP, LDAP, Redis, MySQL, PostgreSQL and MongoDB.
  5.Cross-platform Builds and Deployment. Run the broker on Linux, Unix, Windows, Raspberry Pi and ARM platform.

Version 2.1::

  Release Date: 2017-02-24
  1.Tuning GC
  2.Dashboard Plugin
  3.


Version 2.2::

  Release Date: 2017-05-05
  Many new features including Web Hook, Lua Hook and Proxy Protocol have been released 
  1.MQTT Listeners
  Support to configure multiple MQTT TCP/SSL listeners for one EMQ node
                           -------
  -- External TCP 1883 --> |     |
                           | EMQ | -- Internal TCP 2883 --> Service
  -- External SSL 8883-->  |     |
                           -------
  2.Proxy Protocol V1/2
  3.Web Hook Plugin
  4.Lua Hook Plugin
  5.Improve the Auth/ACL Chain
  6.Support bcrypt password hash

Version 2.3::

  1.new HTTP Managment API, and supports Hot configuration of some parameters and plugins
  2.Node Discovery and Autocluster:static,mcast,dns,etcd,k8s



