echo命令
#############

说明::

    The echo utility writes any specified operands, separated by single blank (` ') characters 
        and followed by a newline (`\n') character, to the standard output.


.. note:: echo命令在打印到标准输出前都自动加换行符(\n)，如不想加需要增加参数 -n。此问题是在遇到base64数值不正确时发现的。

实例::

    $> echo "1" | base64
    MQo=
    $> echo -n "1" | base64
    MQ==
    $> echo -n "1\n" | base64
    MQo=



