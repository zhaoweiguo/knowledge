规则引擎
############

数据流转
-----------

当设备基于Topic进行通信时，您可以在规则引擎的数据流转中，编写SQL对Topic中的数据进行处理，并配置转发规则将处理后的数据转发到其他Topic或阿里云其他服务。

流转图:

.. figure:: /images/alis/iots/data_flow1.png
   :width: 80%

数据流转方案:


.. figure:: /images/alis/iots/data_flow2.png
   :width: 80%

数据流转过程-自定义Topic:


.. figure:: /images/alis/iots/rule_engine_dataflow2.png
   :width: 80%


数据流转过程-系统Topic:


.. figure:: /images/alis/iots/rule_engine_dataflow3.png
   :width: 80%





SQL表达式:

.. figure:: /images/alis/iots/data_flow3.png
   :width: 80%

SQL表达式实例::

    某环境传感器用于火灾预警，可以采集温度、湿度及气压数据，上报数据内容如下：
    {
      "temperature":25.1
      "humidity":65
      "pressure":101.5
      "location":"xxx,xxx"
    }
    % SQL规则: 温度大于38，湿度小于40时，触发报警
    SELECT temperature as t, deviceName() as deviceName, location 
    FROM /ProductA/+/update 
    WHERE temperature > 38 and humidity < 40

    % 更详细的需要时细看

函数列表::

    SELECT 
      case flag 
        when 1 then '开灯'
        when 2 then '关灯' 
        else '' 
      end flag，deviceName(),abs(temperature) tmr 
    FROM "/topic/#" 
    WHERE temperature>10 and topic(2)='123'

    % 更详细的需要时细看: https://help.aliyun.com/document_detail/30555.html


数据流转的数据格式详情见: https://help.aliyun.com/document_detail/73736.html


场景联动
------------
::

    1.触发条件
    2.过滤条件
    3.执行动作















