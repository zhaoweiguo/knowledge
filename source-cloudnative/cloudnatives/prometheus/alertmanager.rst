alertmanager [1]_
#################

安装
====

linux版安装
-----------

基本::

    VERSION="0.20.0"   // 20200118最新版
    wget https://github.com/prometheus/alertmanager/releases/download/v$PROMETHEUS_VERSION/alertmanager-$VERSION.linux-amd64.tar.gz -O /tmp/alertmanager-$PROMETHEUS_VERSION.linux-amd64.tar.gz
    tar -xvzf /tmp/alertmanager-$PROMETHEUS_VERSION.linux-amd64.tar.gz --directory /tmp/ --strip-components=1
    
    $ /tmp/alertmanager --version


Docker版安装
------------

::

    $ docker run \
      -p 9090:9090 \
      prom/alertmanager

amtool
------

amtool is a cli tool for interacting with the Alertmanager API. It is bundled with all releases of Alertmanager.

install::

    $ go get github.com/prometheus/alertmanager/cmd/amtool

$ amtool alert::

    Alertname        Starts At                Summary
    Test_Alert       2017-08-02 18:30:18 UTC  This is a testing alert!
    Test_Alert       2017-08-02 18:30:18 UTC  This is a testing alert!

$ amtool -o extended alert::

    Labels                                        Annotations                                                    Starts At                Ends At                  Generator URL
    alertname="Test_Alert" instance="node0"       link="https://example.com" summary="This is a testing alert!"  2017-08-02 18:31:24 UTC  0001-01-01 00:00:00 UTC  http://my.testing.script.local
    alertname="Test_Alert" instance="node1"       link="https://example.com" summary="This is a testing alert!"  2017-08-02 18:31:24 UTC  0001-01-01 00:00:00 UTC  http://my.testing.script.local

In addition to viewing alerts, you can use the rich query syntax provided by Alertmanager::

    $ amtool -o extended alert query alertname="Test_Alert"
    Labels                                   Annotations                                                    Starts At                Ends At                  Generator URL
    alertname="Test_Alert" instance="node0"  link="https://example.com" summary="This is a testing alert!"  2017-08-02 18:31:24 UTC  0001-01-01 00:00:00 UTC  http://my.testing.script.local
    alertname="Test_Alert" instance="node1"  link="https://example.com" summary="This is a testing alert!"  2017-08-02 18:31:24 UTC  0001-01-01 00:00:00 UTC  http://my.testing.script.local

    $ amtool -o extended alert query instance=~".+1"
    Labels                                        Annotations                                                    Starts At                Ends At                  Generator URL
    alertname="Test_Alert" instance="node1"       link="https://example.com" summary="This is a testing alert!"  2017-08-02 18:31:24 UTC  0001-01-01 00:00:00 UTC  http://my.testing.script.local
    alertname="Check_Foo_Fails" instance="node1"  link="https://example.com" summary="This is a testing alert!"  2017-08-02 18:31:24 UTC  0001-01-01 00:00:00 UTC  http://my.testing.script.local

    $ amtool -o extended alert query alertname=~"Test.*" instance=~".+1"
    Labels                                   Annotations                                                    Starts At                Ends At                  Generator URL
    alertname="Test_Alert" instance="node1"  link="https://example.com" summary="This is a testing alert!"  2017-08-02 18:31:24 UTC  0001-01-01 00:00:00 UTC  http://my.testing.script.local







.. [1]  https://github.com/prometheus/alertmanager