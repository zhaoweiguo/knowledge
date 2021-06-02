数据解析
----------

由于低配置且资源受限，或者对网络流量有要求的设备，不适合直接构造JSON数据与物联网平台通信，可将原数据透传到物联网平台。您需在物联网平台控制台，编写数据解析脚本，用于将设备上下行数据分别解析为物联网平台定义的标准格式（Alink JSON）和设备的自定义数据格式。


脚本解析::

    可实现json<-->binary

数据解析流程:

.. figure:: /images/alis/iots/data_parse1.png
   :width: 80%


脚本格式::

    /**
     *  将Alink协议的数据转换为设备能识别的格式数据， 物联网平台给设备下发数据时调用
     *  入参：jsonObj 对象       不能为空
     *  出参：rawData byte[]数组 不能为空
     *
     */
    function protocolToRawData(jsonObj) {
        return rawdata;
    }

    /**
     * 将设备的自定义格式数据转换为Alink协议的数据， 设备上报数据到物联网平台时调用
     * 入参：rawData byte[]数组   不能为空
     * 出参：jsonObj 对象         不能为空   
     */
    function rawDataToProtocol(rawData) {
        return jsonObj;
    }

实例:

.. literalinclude:: /files/alis/iots/data_parse_example1.js
   :language: javascript
   :linenos:








